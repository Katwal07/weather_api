import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';

part 'location.g.dart';

@HiveType(typeId: 0)
class LocationModelForStorage {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final double? tempC;
  @HiveField(2)
  final String? weatherCon;
  @HiveField(3)
  final String? weatherIcon;

    LocationModelForStorage({
    required this.name,
    required this.tempC,
    required this.weatherCon,
    required this.weatherIcon,
  });

  factory LocationModelForStorage.fromEntity(
          LocationEntityForStorage location) =>
      LocationModelForStorage(
        name: location.name,
        tempC: location.tempC,
        weatherCon: location.weatherCon ?? '', 
        weatherIcon: location.weatherIcon ?? '',
      );



  LocationEntityForStorage toEntity() => LocationEntityForStorage(
        name: name,
        tempC: tempC,
        weatherCon: weatherCon,
        weatherIcon: weatherIcon,
      );
}
