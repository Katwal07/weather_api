import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/core/error/failure.dart';
import 'package:weather_app_api/modules/home/presentation/logic/weather/weather_state.dart';

import '../../../../../core/usecase/usecase.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  void execute({
    required Usecase usecase,
    required dynamic param1,
    required dynamic param2,
  }) async {
    emit(WeatherLoadingState());

    Either returnedData = await usecase.call(param1: param1, param2: param2);
    return returnedData.fold((error) {
      String errorMessage = "No Location Found";
      if (error is ServerFailure) {
        errorMessage = error.message ?? "Failed to Fetch Weather";
        emit(FailToLoadWeatherState(errorMessage: errorMessage));
      } else if (error is UnExceptedFailure) {
        errorMessage = error.message ?? "UnExpected error occured";
      }
      emit(FailToLoadWeatherState(errorMessage: errorMessage));
    }, (data) {
      emit(WeatherLoadedState(weatherData: data, message: "Successfully load weather details"));
    });
  }
}
