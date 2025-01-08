import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/modules/home/presentation/logic/weather/weather_state.dart';

import '../../../../../core/usecase/usecase.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  void execute({
    required Usecase usecase,
    required dynamic param1,
    required dynamic param2,
  }) async{
    emit(WeatherLoadingState());

    Either returnedData = await usecase.call(param1: param1, param2: param2);
    returnedData.fold(
      (error){
        emit(FailToLoadWeatherState(errorMessage: error));
      }, 
      (data){
        emit(WeatherLoadedState(weatherData: data));
      }
    );
  }
}
