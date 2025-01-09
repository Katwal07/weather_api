import 'package:geolocator/geolocator.dart';

class GeolocatorWrapper {
  Future<bool> isLocationServiceEnabled() async{
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> checkPermission() async{
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async{
    return await Geolocator.requestPermission();
  }

  Future<Position> getCurrentPosition() async{
    return await Geolocator.getCurrentPosition();
  }
}