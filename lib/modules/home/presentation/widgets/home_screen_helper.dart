import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_api/core/config/assets/network_image.dart';
import 'package:weather_app_api/core/constant/text_constant.dart';
import 'package:weather_app_api/core/utils/res/resolution.dart';
import 'package:weather_app_api/modules/home/presentation/logic/helper/home_helper_cubit.dart';

import '../../../../core/config/theme/colors.dart';
import '../logic/helper/home_helper_state.dart';

class HomeScreenHelper extends StatelessWidget {
  const HomeScreenHelper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeHelperCubit()..transitionToHomeScreenFromHelperScreen(),
      child: BlocListener<HomeHelperCubit, HomeHelperState>(
        listener: (context, state) {
          if (state is HomeHelperLoadedState) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              /// Custom Background Frame of Home Helper Screen
              _buildBackgroundFrame(),
              Padding(
                /// Custom Padding of Home Helper Screen
                padding: _buildPadding(),
                child: Column(
                  spacing: 10.2 * AppResolution.heightMultiplier,
                  children: [
                    /// Heading Text of Home Helper Screen
                    _buildTextView(context),

                    /// Skip Button of Home Helper Screen
                    _buildSkipButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextView(BuildContext context) {
    return Center(
      child: Text(
        TextConstant.helperTextForHomeScreen,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: AppColors.onSurfaceColor),
      ),
    );
  }

  Widget _buildBackgroundFrame() {
    return Positioned.fill(
      child: CachedNetworkImage(
        imageUrl: NetworkImageStrings.imageUrl,
        placeholder: (context, url) => Image.asset(
          NetworkImageStrings.placeHolderImage,
          fit: BoxFit.contain,
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.error,
            color: AppColors.error,
            size: 9.3 * AppResolution.imageSizeMultiplier,
          ),
        ),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        TextConstant.skip,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }

  EdgeInsets _buildPadding() {
    return EdgeInsets.only(
      left: 18.6 * AppResolution.widthMultiplier,
      right: 18.6 * AppResolution.widthMultiplier,
      top: 30.4 * AppResolution.heightMultiplier,
    );
  }
}
