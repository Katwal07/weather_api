import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/core/config/theme/colors.dart';
import 'package:weather_app_api/common/constant/text_constant.dart';
import 'package:weather_app_api/core/utils/res/resolution.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_weather_details_usecase.dart';
import 'package:weather_app_api/modules/home/presentation/logic/button/button_name_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/location_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/hive/hive_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/weather/weather_cubit.dart';
import 'package:weather_app_api/service_locator.dart';
import '../../../../common/widgets/elevated_button.dart';
import '../../../../common/widgets/text_field.dart';
import '../logic/geolocator/location_state.dart';
import '../logic/hive/hive_state.dart';
import '../logic/weather/weather_state.dart';

class HomeScreenWidget extends StatefulWidget {
  HomeScreenWidget({
    super.key,
  });

  final TextEditingController locationNameCon = TextEditingController();

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  void initState() {
    super.initState();
    widget.locationNameCon.addListener(() {
      final text = widget.locationNameCon.text.trim();
      context.read<ButtonNameCubit>().onUpdateButtonName(text);
    });
  }

  @override
  void dispose() {
    widget.locationNameCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        /// Cusotm Padding
        padding: _buildPadding(),
        child: Column(
          spacing: 4.3 * AppResolution.heightMultiplier,
          children: [
            /// Enter Location Name TextField
            _buildLocationNameTextField(),

            /// Location Details Widget
            _buildLocationDetailsWidget(),

            /// Spacer
            Spacer(),

            /// Save or Update Button
            _buildSaveOrUpdateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationNameTextField() {
    return CustomTextField(
      controller: widget.locationNameCon,
      hintText: TextConstant.enterLocName,
      prefixIcon: Icon(Icons.search),
    );
  }

  Widget _buildSaveOrUpdateButton(BuildContext context) {
    /// Location Cubit
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        /// Button Name Cubit
        return BlocBuilder<ButtonNameCubit, String>(
          builder: (context, buttonState) {
            if (state is LocationSuccessState) {
              final latitude = state.position.latitude;
              final longitude = state.position.longitude;
              final coordQuery = "$latitude,$longitude";

              return CustomElevatedButton(
                buttonText: buttonState,
                onPressed: () {
                  final locationName = widget.locationNameCon.text.trim();
                  if (locationName.isNotEmpty) {
                    context.read<WeatherCubit>().execute(
                          usecase: sl<GetWeatherDetailsUsecase>(),
                          param1: locationName,
                          param2: "yes",
                        );
                  } else {
                    context.read<WeatherCubit>().execute(
                          usecase: sl<GetWeatherDetailsUsecase>(),
                          param1: coordQuery,
                          param2: "yes",
                        );
                  }
                },
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  EdgeInsets _buildPadding() {
    return EdgeInsets.symmetric(
      horizontal: 4.65 * AppResolution.widthMultiplier,
      vertical: 2.15 * AppResolution.heightMultiplier,
    );
  }

  Widget _buildLocationDetailsWidget() {
    return Container(
      height: 21.45 * AppResolution.heightMultiplier,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius:
            BorderRadius.circular(2.32 * AppResolution.widthMultiplier),
      ),

      /// Weather Cubit
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadedState) {
            final iconUrl = state.weatherData.current!.condition!.icon ?? '';
            final fullIconUrl =
                iconUrl.startsWith('http') ? iconUrl : 'https:$iconUrl';

            /// Save The Location
            final saveLocation = LocationEntityForStorage(
              name: state.weatherData.location!.name ?? '',
              tempC: state.weatherData.current!.tempC,
              weatherCon: state.weatherData.current!.condition!.text ?? '',
              weatherIcon: fullIconUrl,
            );

            /// Call The Cubit To Save the Location
            context.read<HiveCubit>().saveNewLocation(saveLocation);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  scale: 0.6,
                  fullIconUrl,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Place Name: ${state.weatherData.location!.name!}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Temperature: ${state.weatherData.current!.tempC!}°C",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Weather Condition: ${state.weatherData.current!.condition!.text!}",
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is WeatherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FailToLoadWeatherState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is WeatherInitialState) {
            context.read<HiveCubit>().getSavedLocation();
            return BlocBuilder<HiveCubit, HiveState>(
              builder: (context, hiveState) {
                if (hiveState is HiveLoadedState &&
                    hiveState.location != null) {
                  final iconUrl = hiveState.location!.weatherIcon ?? '';
                  final fullIconUrl = iconUrl.startsWith('http')
                      ? iconUrl
                      : iconUrl.isNotEmpty
                          ? 'https:$iconUrl'
                          : 'https://cdn.weatherapi.com/weather/64x64/day/116.png';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        scale: 0.6,
                        fullIconUrl,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Place Name: ${hiveState.location!.name}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Temperature: ${hiveState.location!.tempC!}°C",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Weather Condition: ${hiveState.location!.weatherCon!}",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (hiveState is FailToLoadHive) {
                  return Center(child: Text("Hive is Empty"));
                }
                return const SizedBox.shrink();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
