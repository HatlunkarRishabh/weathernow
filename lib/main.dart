import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/weather_model.dart';
import 'models/daily_forecast_model.dart';
import 'providers/weather_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(DailyForecastModelAdapter());
   await Hive.openBox<WeatherModel>('weather_box');
   await Hive.openBox<DailyForecastModel>('daily_forecast_box');
   await Hive.openBox('settings'); // open the settings box;
   runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
         title: 'Flutter Weather App',
         theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
           useMaterial3: true,
          ),
        home: const SplashScreen(),
      );
  }
}