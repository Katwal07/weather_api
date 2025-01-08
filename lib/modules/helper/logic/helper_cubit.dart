import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/modules/helper/logic/helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit() : super(HelperInitialState());

  void transitionToHomeScreen() async {
    try {
      await Future.delayed(Duration(milliseconds: 5000));

      if(!isClosed){
        emit(HelperLoadedState());
      }
    } catch (e) {
      emit(HelperFailureState(errorMessage: e.toString()));
    }
  }
}
