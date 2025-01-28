import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../services/network_service.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isNetworkConnected = true;
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
      _checkNetworkAndLoadData();
  }
  Future<void> _checkNetworkAndLoadData() async {
    _isNetworkConnected = await NetworkService.isConnected();
    if (_isNetworkConnected) {
       await _loadData();
    }
    else{
       setState(() {
        _isInitialized = true;
       });
    }
  }
  Future<void> _loadData() async {
  // Modified to call loadStoredCity instead of _loadStoredCity.
   await  Provider.of<WeatherProvider>(context, listen: false).loadStoredCity();
   WidgetsBinding.instance.addPostFrameCallback((_) {
     if (Provider.of<WeatherProvider>(context,listen: false).selectedCity.isEmpty && Provider.of<WeatherProvider>(context,listen: false).weatherData == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const SearchScreen()));
      }
      else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomeScreen()));
      }
    });
  }

   void _retry() {
       setState(() {
        _isInitialized = false;
       });
      _checkNetworkAndLoadData();
   }
  @override
  Widget build(BuildContext context) {
       if (!_isInitialized) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
    else if (!_isNetworkConnected) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No Network Connection',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                 onPressed: _retry,
                  child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else{
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
         ),
      );
    }
  }
}