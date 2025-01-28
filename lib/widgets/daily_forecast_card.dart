import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathernow/widgets/weather_icon.dart';
import '../models/daily_forecast_model.dart';

class DailyForecastCard extends StatelessWidget {
  final DailyForecastModel forecast;
  const DailyForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Card(
          elevation: 2,
          child: Padding(
              padding: const EdgeInsets.all(8.0), // Reduced padding
            child: SizedBox(
              width: constraints.maxWidth/ 1.5,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                      DateFormat('EEE, d MMM').format(forecast.date),
                       style: Theme.of(context).textTheme.bodySmall, // Use smaller text style
                     ),
                   const SizedBox(height: 5),
                   WeatherIcon(iconUrl: forecast.conditionIcon, size: 30,),
                     const SizedBox(height: 5),
                   Text(
                     '${forecast.avgTempC.toStringAsFixed(1)}°C',
                       style: Theme.of(context).textTheme.bodySmall, // Use smaller text style
                    ),
                  ],
                ),
            ),
        ),
      );
        }
    );
  }
}