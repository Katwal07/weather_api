import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_saved_location_usecase.dart';
import 'package:weather_app_api/modules/home/domain/usecases/save_location_usecase.dart';
import 'package:weather_app_api/modules/home/presentation/logic/hive/hive_state.dart';
import 'package:weather_app_api/service_locator.dart';

class HiveCubit extends Cubit<HiveState> {
  HiveCubit() : super(HiveInitialState());

  Future<void> saveNewLocation(LocationEntityForStorage location) async {
    emit(HiveLoadingState());
    var returnedData = await sl<SaveLocationUsecase>().call(param: location);
    returnedData.fold(
      (error) {
        emit(FailToLoadHive(errorMessage: error.toString()));
      },
      (_) {
        emit(HiveSavedState());
      },
    );
  }

  Future<void> getSavedLocation() async {
    emit(HiveLoadingState());
    var returnedData = await sl<GetSavedLocationUseCase>().call();
    returnedData.fold(
      (error) {
        emit(
          FailToLoadHive(
            errorMessage: error.toString(),
          ),
        );
      },
      (data) {
        emit(
          HiveLoadedState(location: data),
        );
      },
    );
  }
}
