import 'package:hive/hive.dart';
part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel {
  @HiveField(0)
  final String? locationName;
  @HiveField(1)
  final double? tempC;
  @HiveField(2)
  final double? humidity;
  @HiveField(3)
  final double? windKph;
  @HiveField(4)
  final double? pressureMb;
  @HiveField(5)
  final int? cloud;
  @HiveField(6)
  final String? conditionText;
  @HiveField(7)
  final String? conditionIcon;
  @HiveField(8)
  final double? uv;
  @HiveField(9)
  final int? pollenLevel;
  @HiveField(10)
   final DateTime? lastUpdated;
  
  WeatherModel({
      this.locationName,
      this.tempC,
      this.humidity,
      this.windKph,
      this.pressureMb,
      this.cloud,
      this.conditionText,
      this.conditionIcon,
      this.uv,
      this.pollenLevel,
      this.lastUpdated,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
       locationName: json['location']['name'],
      tempC: json['current']['temp_c']?.toDouble(),
      humidity: json['current']['humidity']?.toDouble(),
      windKph: json['current']['wind_kph']?.toDouble(),
      pressureMb: json['current']['pressure_mb']?.toDouble(),
      cloud: json['current']['cloud']?.toInt(),
      conditionText: json['current']['condition']['text'],
      conditionIcon: json['current']['condition']['icon'],
      uv: json['current']['uv']?.toDouble(),
      pollenLevel: json['current']['air_quality']?['pollen_level']?.toInt(),
       lastUpdated: DateTime.now()
    );
  }
}