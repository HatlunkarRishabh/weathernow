// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyForecastModelAdapter extends TypeAdapter<DailyForecastModel> {
  @override
  final int typeId = 1;

  @override
  DailyForecastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyForecastModel(
      date: fields[0] as DateTime,
      avgTempC: fields[1] as double,
      conditionIcon: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyForecastModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.avgTempC)
      ..writeByte(2)
      ..write(obj.conditionIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyForecastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
