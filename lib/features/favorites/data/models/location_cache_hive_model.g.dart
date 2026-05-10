// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_cache_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationCacheHiveModelAdapter
    extends TypeAdapter<LocationCacheHiveModel> {
  @override
  final int typeId = 1;

  @override
  LocationCacheHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationCacheHiveModel(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      timestamp: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocationCacheHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationCacheHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
