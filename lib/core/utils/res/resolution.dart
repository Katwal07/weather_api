import 'package:flutter/material.dart';

class AppResolution {
  AppResolution._();
  
  static late double screenWidth;
  static late double screenHeight;
  static late TextScaler textScaler;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height / 100;
    screenWidth = mediaQuery.size.width / 100;
    
    debugPrint("Screen Height: $screenHeight");
    debugPrint("Screen Width: $screenWidth");
    debugPrint("Image Size: $screenWidth");
    debugPrint("Text Size: $screenWidth");
  }

  static double widthMultiplier = screenWidth;
  static double heightMultiplier = screenHeight;
  static double imageSizeMultiplier = screenWidth;
  static double textMultipler = screenHeight;
}
