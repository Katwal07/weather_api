import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_helper_state.dart';

class HomeHelperCubit extends Cubit<HomeHelperState> {
  HomeHelperCubit() : super(HomeHelperInitialState());

  void transitionToHomeScreenFromHelperScreen() async {
    try {
      await Future.delayed(Duration(milliseconds: 5000));

      if(!isClosed){
        emit(HomeHelperLoadedState());
      }
    } catch (e) {
      emit(HomeHelperFailureState(errorMessage: e.toString()));
    }
  }
}