import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonNameCubit extends Cubit<String>{
  ButtonNameCubit(): super("SAVE");

  void onUpdateButtonName(String text){
    if(text.trim().isEmpty){
      emit("SAVE");
    }else{
      emit("UPDATE");
    }
  }
}