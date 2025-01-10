import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable{}

class LocationInitialState extends LocationState{
  @override
  List<Object?> get props => [];
}

class LocationLoadingState extends LocationState{
    @override
  List<Object?> get props => [];
}

class LocationSuccessState extends LocationState{
  final Position position;

  LocationSuccessState({required this.position});
    @override
  List<Object?> get props => [position];
}

class LocationFailureState extends LocationState{
  final String errorMessage;

  LocationFailureState({required this.errorMessage});
    @override
  List<Object?> get props => [errorMessage];
}