import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_api/modules/home/presentation/logic/button/button_name_cubit.dart';

void main(){
  group("ButtonNameCubit Tests", (){
    late ButtonNameCubit buttonNameCubit;

    setUp((){
      buttonNameCubit = ButtonNameCubit();
    });

    tearDown((){
      buttonNameCubit.close();
    });

    test('initial state is "SAVE"', (){
      expect(buttonNameCubit.state, "SAVE");
    });

    blocTest<ButtonNameCubit, String>(
      "emits SAVE when imput text is empty or contains only whitespace", 
      build: ()=> buttonNameCubit,
      act: (cubit)=> cubit.onUpdateButtonName("   "),
      expect: ()=> ["SAVE"],
    );

    blocTest<ButtonNameCubit, String>(
      "emits UPDATE when imput text is noy empty or not contains only whitespace", 
      build: ()=> buttonNameCubit,
      act: (cubit)=> cubit.onUpdateButtonName("Hello"),
      expect: ()=> ["UPDATE"],
    );
  });
}