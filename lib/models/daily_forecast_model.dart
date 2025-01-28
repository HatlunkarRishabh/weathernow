import 'package:hive/hive.dart';
part 'daily_forecast_model.g.dart';

@HiveType(typeId: 1)
class DailyForecastModel {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final double avgTempC;
  @HiveField(2)
  final String conditionIcon;

  DailyForecastModel({
    required this.date,
    required this.avgTempC,
    required this.conditionIcon,
  });


  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
        date: DateTime.parse(json['date']),
        avgTempC: json['day']['avgtemp_c']?.toDouble(),
        conditionIcon: json['day']['condition']['icon']
    );
  }
}