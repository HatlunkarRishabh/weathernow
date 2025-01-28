import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../models/daily_forecast_model.dart';
import '../services/weather_service.dart';
import '../services/network_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;
  List<DailyForecastModel> _dailyForecastData = [];
  String _selectedCity = '';
  bool _isLoading = false;
  String? _errorMessage;
  bool _isOnline = true;
   final _weatherBox = Hive.box<WeatherModel>('weather_box');
   final _dailyForecastBox = Hive.box<DailyForecastModel>('daily_forecast_box');

  WeatherModel? get weatherData => _weatherData;
  List<DailyForecastModel> get dailyForecastData => _dailyForecastData;
  String get selectedCity => _selectedCity;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isOnline => _isOnline;

   WeatherProvider() {
        loadStoredCity();
      _loadCachedData();
        _setupConnectivityListener();
  }
    void _setupConnectivityListener() {
   NetworkService.connectivityStream().listen((isOnline) {
     _isOnline = isOnline;
      notifyListeners();
   });
  }

   Future<void> loadStoredCity() async {
      final city = Hive.box('settings').get('selected_city', defaultValue: '');
      if(city != ''){
         _selectedCity = city;
          fetchWeatherData(city, false);
       } else{
           await fetchWeatherByLocation(false);
        }
  }
  
   Future<void> _loadCachedData() async {
      if (_weatherBox.isNotEmpty) {
        _weatherData = _weatherBox.getAt(0);
      }
      if(_dailyForecastBox.isNotEmpty){
           _dailyForecastData = _dailyForecastBox.values.toList();
      }
    notifyListeners();
  }
  
  Future<void> setSelectedCity(String city) async {
       _selectedCity = city;
    await Hive.box('settings').put('selected_city', city);
    notifyListeners();
    await  fetchWeatherData(city, true);
  }

  Future<void> fetchWeatherData(String city, bool refresh) async {
     _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
           if (!await NetworkService.isConnected() && !refresh) {
            _errorMessage = 'No internet connection. Showing cached data.';
          } else {
            final data = await WeatherService().fetchFiveDayForecast(city);
              _weatherData = data['weather'];
              _dailyForecastData = data['forecast'];
             if(refresh){
                    await  _weatherBox.clear();
                    await _dailyForecastBox.clear();
                   await _weatherBox.add(_weatherData!);
                   await  _dailyForecastBox.addAll(_dailyForecastData);
                }
          }
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
          _isLoading = false;
          notifyListeners();
      }
  }
   Future<void> fetchWeatherByLocation(bool refresh) async {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
          if (!await NetworkService.isConnected() && !refresh) {
            _errorMessage = 'No internet connection. Showing cached data.';
          } else{
           final position = await _getCurrentLocation();
              if(position != null){
              final data = await WeatherService().fetchFiveDayForecast('${position.latitude},${position.longitude}');
                _weatherData = data['weather'];
                _dailyForecastData = data['forecast'];
                if(refresh){
                  await  _weatherBox.clear();
                  await _dailyForecastBox.clear();
                  await _weatherBox.add(_weatherData!);
                  await  _dailyForecastBox.addAll(_dailyForecastData);
                }
              }
           }
      }
      catch (e) {
          _errorMessage = e.toString();
       }
        finally {
          _isLoading = false;
          notifyListeners();
      }
  }
  Future<Position?> _getCurrentLocation() async {
     bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _errorMessage = 'Location services are disabled';
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _errorMessage = 'Location permissions are denied';
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _errorMessage = 'Location permissions are permanently denied, we cannot request permissions.';
      return null;
    }

    try{
       return await Geolocator.getCurrentPosition();
    }
    catch(e){
        _errorMessage = e.toString();
        return null;
    }
  }
  Future<void> refreshData() async {
   if(_selectedCity.isNotEmpty)
      {
         await  fetchWeatherData(_selectedCity, true);
      }
      else {
          await fetchWeatherByLocation(true);
      }
  }
}