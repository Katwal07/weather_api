
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_api/modules/home/presentation/logic/helper/home_helper_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/helper/home_helper_state.dart';

void main(){
  group("Home Helper Cubit Tests", (){
    late HomeHelperCubit homeHelperCubit;

    setUp((){
      homeHelperCubit = HomeHelperCubit();
    });

    tearDown((){
      homeHelperCubit.close();
    });

    test("initial state is HelperInitialState", (){
      expect(homeHelperCubit.state, isA<HomeHelperInitialState>());
    });

    blocTest<HomeHelperCubit, HomeHelperState>(
      'emit [HelperLoadedState] after successful transition', 
      build: ()=> homeHelperCubit,
      act: (cubit)=> cubit.transitionToHomeScreenFromHelperScreen(),
      wait: const Duration(milliseconds: 5100),
      expect: ()=> [isA<HomeHelperLoadedState>()],
    );

    blocTest<HomeHelperCubit, HomeHelperState>(
      'emit [HelperFailureState] when an exception occurs', 
      build: ()=> homeHelperCubit,
      act: (cubit)=> cubit.emit(HomeHelperFailureState(errorMessage: "Error occured")),
      wait: const Duration(milliseconds: 5100),
      expect: ()=> [isA<HomeHelperFailureState>()],
    );
  });
}