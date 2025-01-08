import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_api/service_locator.dart';
import 'app/weather_app.dart';
import 'modules/home/data/models/location.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(LocationModelForStorageAdapter());
  final locationBox = await Hive.openBox<LocationModelForStorage>('locationBox');
  setUpServiceLocator(locationBox);
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const WeatherApp());
}