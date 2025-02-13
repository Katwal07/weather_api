import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/common/widgets/appbar.dart';
import 'package:weather_app_api/common/widgets/snackbar.dart';
import 'package:weather_app_api/core/config/routes/routes_name.dart';
import 'package:weather_app_api/core/config/theme/colors.dart';
import 'package:weather_app_api/common/constant/text_constant.dart';
import 'package:weather_app_api/core/utils/res/resolution.dart';
import 'package:weather_app_api/modules/home/presentation/logic/button/button_name_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/geolocator_wrapper.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/location_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/hive/hive_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/weather/weather_cubit.dart';
import '../logic/weather/weather_state.dart';
import '../widgets/home_screen_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isShownSnackBar = false;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(),
        ),
        BlocProvider(
          create: (context) => ButtonNameCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(geolocatorWrapper: GeolocatorWrapper())..getLocation(),
        ),
        BlocProvider(
          create: (context) => HiveCubit(),
        ),
      ],
      child: BlocListener<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if(state is FailToLoadWeatherState && !isShownSnackBar){
            isShownSnackBar = true;
            CustomSnackBar.showCustomSnackBar(context, AppColors.error, state.errorMessage);
            Future.delayed(const Duration(seconds: 2), () {
              isShownSnackBar = false;
            });
          }
          if(state is WeatherLoadedState && !isShownSnackBar){
            isShownSnackBar = true;
            CustomSnackBar.showCustomSnackBar(context, AppColors.primaryColor, state.message!);
            Future.delayed(const Duration(seconds: 2), () {
              isShownSnackBar = false;
            });
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: TextConstant.weatherApi,
            actions: [
              _buildTextButton(context),
            ],
          ),
          body: HomeScreenWidget(),
        ),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 4.65 * AppResolution.widthMultiplier,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(2.8 * AppResolution.widthMultiplier),
          ),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(
            context,
            AppRoutesName.homeHelperScreen,
          );
        },
        child: Text(
          TextConstant.getInfo,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
