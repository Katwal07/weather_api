import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/location_state.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitialState());

  Future<void> getLocation() async {
    emit(LocationLoadingState());

    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isServiceEnabled) {
        emit(
          LocationFailureState(
            errorMessage: "Location Service is Disabled",
          ),
        );
      }

      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          emit(
            LocationFailureState(
              errorMessage: "Location permission are denied",
            ),
          );
        }
      }
      if (locationPermission == LocationPermission.deniedForever) {
        emit(
          LocationFailureState(
            errorMessage:
                "Location permissions are permanently denied, we cannot request permissions.",
          ),
        );
      }

      Position position = await Geolocator.getCurrentPosition();

      emit(LocationSuccessState(position: position));
    } catch (e) {
      emit(LocationFailureState(errorMessage: e.toString()));
    }
  }
}
