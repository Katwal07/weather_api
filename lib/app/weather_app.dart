import 'package:flutter/material.dart';
import 'package:weather_app_api/core/config/routes/routes.dart';
import 'package:weather_app_api/core/config/routes/routes_name.dart';
import 'package:weather_app_api/core/config/theme/theme.dart';
import 'package:weather_app_api/core/utils/res/resolution.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppResolution.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      themeMode: ThemeMode.light,
      title: 'Weather App',
      initialRoute: AppRoutesName.helperScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}