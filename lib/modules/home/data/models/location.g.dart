// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelForStorageAdapter
    extends TypeAdapter<LocationModelForStorage> {
  @override
  final int typeId = 0;

  @override
  LocationModelForStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModelForStorage(
      name: fields[0] as String?,
      tempC: fields[1] as double?,
      weatherCon: fields[2] as String?,
      weatherIcon: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationModelForStorage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tempC)
      ..writeByte(2)
      ..write(obj.weatherCon)
      ..writeByte(3)
      ..write(obj.weatherIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelForStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
