// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 0;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      locationName: fields[0] as String?,
      tempC: fields[1] as double?,
      humidity: fields[2] as double?,
      windKph: fields[3] as double?,
      pressureMb: fields[4] as double?,
      cloud: fields[5] as int?,
      conditionText: fields[6] as String?,
      conditionIcon: fields[7] as String?,
      uv: fields[8] as double?,
      pollenLevel: fields[9] as int?,
      lastUpdated: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.locationName)
      ..writeByte(1)
      ..write(obj.tempC)
      ..writeByte(2)
      ..write(obj.humidity)
      ..writeByte(3)
      ..write(obj.windKph)
      ..writeByte(4)
      ..write(obj.pressureMb)
      ..writeByte(5)
      ..write(obj.cloud)
      ..writeByte(6)
      ..write(obj.conditionText)
      ..writeByte(7)
      ..write(obj.conditionIcon)
      ..writeByte(8)
      ..write(obj.uv)
      ..writeByte(9)
      ..write(obj.pollenLevel)
      ..writeByte(10)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
