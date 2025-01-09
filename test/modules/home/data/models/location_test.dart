import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_api/modules/home/data/models/location.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';

void main() {
  setUp(() async {
    Hive.init(Directory.current.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LocationModelForStorageAdapter());
    }
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  group("LocationModelForStorage test", () {
    test(
        'LocationModelForStorage fromEntity and toEntity should work correctly',
        () async {
      final testLocationEntity = LocationEntityForStorage(
        name: "Pokhara",
        tempC: 25.0,
        weatherCon: "Clear",
        weatherIcon: "sunny",
      );

      final locationModelForStorage = LocationModelForStorage.fromEntity(testLocationEntity);
      expect(locationModelForStorage, isA<LocationModelForStorage>());


      final convertedEntity = locationModelForStorage.toEntity();
      expect(convertedEntity, isA<LocationEntityForStorage>());
    });

    test("LocationModelForStorage should store and retrieve to and from Hive correctly", () async{
      final testLocationModel = LocationModelForStorage(
        name: "Pokhara",
        tempC: 25.0,
        weatherCon: "Clear",
        weatherIcon: "sunny",
      );

      /// Store the hive in model
      final box = await Hive.openBox<LocationModelForStorage>('test_box');
      await box.put('location_key', testLocationModel);

      /// Retrieve the model from hive
      final retrievedModel = box.get('location_key') as LocationModelForStorage;

      expect(retrievedModel, equals(testLocationModel));
    });
  });
}
