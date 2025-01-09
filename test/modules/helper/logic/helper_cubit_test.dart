
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_api/modules/helper/logic/helper_cubit.dart';
import 'package:weather_app_api/modules/helper/logic/helper_state.dart';

void main(){
  group("Helper Cubit Tests", (){
    late HelperCubit helperCubit;

    setUp((){
      helperCubit = HelperCubit();
    });

    tearDown((){
      helperCubit.close();
    });

    test("initial state is HelperInitialState", (){
      expect(helperCubit.state, isA<HelperInitialState>());
    });

    blocTest<HelperCubit, HelperState>(
      'emit [HelperLoadedState] after successful transition', 
      build: ()=> helperCubit,
      act: (cubit)=> cubit.transitionToHomeScreen(),
      wait: const Duration(milliseconds: 5100),
      expect: ()=> [isA<HelperLoadedState>()],
    );

    blocTest<HelperCubit, HelperState>(
      'emit [HelperFailureState] when an exception occurs', 
      build: ()=> helperCubit,
      act: (cubit)=> cubit.emit(HelperFailureState(errorMessage: "Error occured")),
      wait: const Duration(milliseconds: 5100),
      expect: ()=> [isA<HelperFailureState>()],
    );
  });
}