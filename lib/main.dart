import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app_api/service_locator.dart';
import 'app/weather_app.dart';

void main() async{
  setUpServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const WeatherApp());
}