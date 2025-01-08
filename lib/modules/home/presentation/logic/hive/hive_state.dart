import 'package:weather_app_api/modules/home/domain/entities/location.dart';

abstract class HiveState {}

class HiveInitialState extends HiveState{}

class HiveLoadingState extends HiveState{}

class HiveLoadedState extends HiveState{
  final LocationEntityForStorage? location;

  HiveLoadedState({required this.location});
}

class HiveSavedState extends HiveState{}

class FailToLoadHive extends HiveState{
  final String errorMessage;

  FailToLoadHive({required this.errorMessage});
}