import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/geolocator_wrapper.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/location_state.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationState> {
  final GeolocatorWrapper geolocatorWrapper;

  LocationCubit({required this.geolocatorWrapper}) : super(LocationInitialState());

  Future<void> getLocation() async {
    emit(LocationLoadingState());
    
    try {
      // First check if location services are enabled
      final bool serviceEnabled = await geolocatorWrapper.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit( LocationFailureState(errorMessage: "Location Service is Disabled"));
        return; // Exit early if services are disabled
      }

      // Only check permissions if location services are enabled
      LocationPermission permission = await geolocatorWrapper.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await geolocatorWrapper.requestPermission();
        if (permission == LocationPermission.denied) {
          emit( LocationFailureState(errorMessage: "Location permission are denied"));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit( LocationFailureState(
          errorMessage: "Location permissions are permanently denied, we cannot request permissions.",
        ));
        return;
      }

      final position = await geolocatorWrapper.getCurrentPosition();
      emit(LocationSuccessState(position: position));
      
    } catch (e) {
      emit(LocationFailureState(errorMessage: e.toString()));
    }
  }
}