import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/core/config/routes/routes_name.dart';
import 'package:weather_app_api/modules/helper/logic/helper_cubit.dart';
import '../logic/helper_state.dart';
import '../widgets/helper_screen_details.dart';

class HelperScreen extends StatelessWidget {
  const HelperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelperCubit()..transitionToHomeScreen(),
      child: BlocListener<HelperCubit, HelperState>(
        listener: (context, state) {
          if (state is HelperLoadedState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutesName.homeScreen,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          /// HelperScreenDetails Widget
          body: HelperScreenDetails(),
        ),
      ),
    );
  }
}
