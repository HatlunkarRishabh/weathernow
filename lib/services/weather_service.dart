 import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/daily_forecast_model.dart';
import '../utils/constants.dart';

class WeatherService {
  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    final String apiUrl = '$baseUrl/current.json?key=$apiKey&q=$city&aqi=yes';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
         final data = json.decode(response.body);
          if (data == null){
            throw Exception('API returned null data');
          }
        final weatherData = WeatherModel.fromJson(data);
        List<DailyForecastModel> forecastData = [];
        try{
            if(data['forecast'] != null && data['forecast']['forecastday'] != null){
               forecastData = (data['forecast']['forecastday'] as List)
                    .map((forecastJson) => DailyForecastModel.fromJson(forecastJson)).toList();
           }
        } catch(e){
           if (kDebugMode) {
            print('Error parsing forecast data: $e');
           }
        }
        return {'weather': weatherData, 'forecast': forecastData};
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('Failed to load weather data');
    }
  }
   Future<Map<String, dynamic>> fetchFiveDayForecast(String city) async {
     final String apiUrl = '$baseUrl/forecast.json?key=$apiKey&q=$city&days=5&aqi=no';
     try {
       final response = await http.get(Uri.parse(apiUrl));

       if (response.statusCode == 200) {
         final data = json.decode(response.body);
          if(data == null){
          throw Exception('API returned null data');
         }
           final weatherData = WeatherModel.fromJson(data);
            final forecastData = (data['forecast']['forecastday'] as List)
                .map((forecastJson) => DailyForecastModel.fromJson(forecastJson)).toList();
           return {'weather':weatherData, 'forecast':forecastData};
       } else {
         throw Exception('Failed to load forecast data');
       }
     } catch (e) {
       if (kDebugMode) {
         print(e);
       }
       throw Exception('Failed to load forecast data');
     }
   }
  Future<Map<String, dynamic>> fetchWeatherDataByLocation(double latitude, double longitude) async {
    final String apiUrl = '$baseUrl/current.json?key=$apiKey&q=$latitude,$longitude&aqi=yes';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
          final data = json.decode(response.body);
           if (data == null){
               throw Exception('API returned null data');
           }
        final weatherData = WeatherModel.fromJson(data);
         List<DailyForecastModel> forecastData = [];
        try{
            if(data['forecast'] != null && data['forecast']['forecastday'] != null){
              forecastData = (data['forecast']['forecastday'] as List)
                  .map((forecastJson) => DailyForecastModel.fromJson(forecastJson)).toList();
           }
         } catch(e){
           if (kDebugMode) {
           print('Error parsing forecast data: $e');
           }
         }
        return {'weather': weatherData, 'forecast': forecastData};
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('Failed to load weather data');
    }
  }
}