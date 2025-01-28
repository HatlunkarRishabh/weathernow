import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/error_widget.dart';
import '../screens/search_screen.dart';
import '../widgets/skeleton_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Now'),
        actions: [
           IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () => fetchWeatherByLocation(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshData(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToSearchScreen(context),
        child: const Icon(Icons.search),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const WeatherSkeleton();
          }
          if (provider.errorMessage != null) {
            return ErrorDisplay(message: provider.errorMessage!);
          }
          if (!provider.isOnline) {
            return const Center(
              child: Text(
                'No network connection available',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          if (provider.weatherData == null) {
            return const Center(child: Text('No data available.'));
          }
          return Column(
            children: [
              WeatherCard(weather: provider.weatherData!),
              if (provider.dailyForecastData.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      '5 Day Forecast',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.dailyForecastData.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: 110,
                            child: DailyForecastCard(
                                forecast: provider.dailyForecastData[index]));
                      }),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _navigateToSearchScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SearchScreen()));
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).refreshData();
  }
  Future<void> fetchWeatherByLocation(BuildContext context) async {
    await  Provider.of<WeatherProvider>(context, listen: false).fetchWeatherByLocation(true);
  }
}