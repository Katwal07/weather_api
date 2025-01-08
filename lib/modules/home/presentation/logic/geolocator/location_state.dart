import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationInitialState extends LocationState{}

class LocationLoadingState extends LocationState{}

class LocationSuccessState extends LocationState{
  final Position position;

  LocationSuccessState({required this.position});
}

class LocationFailureState extends LocationState{
  final String errorMessage;

  LocationFailureState({required this.errorMessage});
}