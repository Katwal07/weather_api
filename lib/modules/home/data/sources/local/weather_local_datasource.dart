import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_api/core/network/hive_const.dart';
import 'package:weather_app_api/modules/home/data/models/location.dart';

import '../../../../../core/error/exception.dart';

abstract class WeatherLocalDatasource {
  Future<Either<AppException, LocationModelForStorage?>> getSavedLocation();
  Future<Either<AppException, void>> saveLocation(
      LocationModelForStorage location);
}

class WeatherLocalDatasourceImpl extends WeatherLocalDatasource {
  final Box<LocationModelForStorage> locationBox;

  WeatherLocalDatasourceImpl({required this.locationBox});

  @override
  Future<Either<AppException, LocationModelForStorage?>>
      getSavedLocation() async {
    try {
      final location = locationBox.get(HiveConstants.locationKey);
      return Right(location);
    } catch (e) {
      return Left(
        CacheException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<AppException, void>> saveLocation(
      LocationModelForStorage location) async{
    try {
      final returnedLocation = locationBox.put(HiveConstants.locationKey, location);
      return Right(returnedLocation);
    } catch (e) {
      return Left(CacheException(message: e.toString()));
    }
  }
}
