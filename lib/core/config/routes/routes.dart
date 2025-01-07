import 'package:flutter/material.dart';
import 'package:weather_app_api/core/config/routes/routes_name.dart';
import 'package:weather_app_api/modules/helper/pages/helper_screen.dart';
import 'package:weather_app_api/modules/home/presentation/pages/home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.helperScreen:
        return MaterialPageRoute(
          builder: (context) => HelperScreen(),
        );
      case AppRoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: SizedBox(
                child: Center(
                  child: Text("NO ROUTE GENERATED"),
                ),
              ),
            );
          },
        );
    }
  }
}
