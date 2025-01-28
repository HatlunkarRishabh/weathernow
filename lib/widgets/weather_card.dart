import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathernow/widgets/weather_icon.dart';
import '../models/weather_model.dart';


class WeatherCard extends StatelessWidget {
   final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16),
      child: Padding(
         padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(
              weather.locationName ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
             WeatherIcon(iconUrl: weather.conditionIcon ?? '',size: 100,),
            const SizedBox(height: 10),
             Text(
              '${weather.tempC}°C',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
              Text(
              weather.conditionText ?? '',
              style: const TextStyle(fontSize: 16),
            ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetail('Humidity', '${weather.humidity}%'),
                   _buildDetail('Wind', '${weather.windKph} km/h'),
                   _buildDetail('Pressure', '${weather.pressureMb} mb'),
                ],
              ),
            const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetail('UV Index', '${weather.uv}'),
                   _buildDetail('Pollen', '${weather.pollenLevel}'),
                ],
              ),
              const SizedBox(height: 10),
             if(weather.lastUpdated != null)
            Text(
              'Last Updated: ${DateFormat('MMM d, h:mm a').format(weather.lastUpdated!)}',
               style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
           ],
         ),
      ),
    );
  }
  Widget _buildDetail(String label, String value){
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black54),),
      ],
    );
  }
}