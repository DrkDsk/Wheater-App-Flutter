// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_location_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityLocationHiveModelAdapter extends TypeAdapter<CityLocationHiveModel> {
  @override
  final int typeId = 0;

  @override
  CityLocationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityLocationHiveModel(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      cityName: fields[2] as String?,
      timestamp: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CityLocationHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.cityName)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityLocationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
