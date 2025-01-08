import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_api/core/config/assets/network_image.dart';
import 'package:weather_app_api/core/config/routes/routes_name.dart';
import 'package:weather_app_api/core/constant/text_constant.dart';
import 'package:weather_app_api/core/utils/res/resolution.dart';
import '../../../core/config/theme/colors.dart';

class HelperScreenDetails extends StatelessWidget {
  const HelperScreenDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Custom Background Frame of Helper Screen
        _buildBackgroundFrame(),
        Padding(
          /// Custom Padding of Helper Screen
          padding: _buildPadding(),
          child: Column(
            spacing: 32.2 * AppResolution.heightMultiplier,
            children: [
              /// Heading Text of Helper Screen
              _buildTextView(context),

              /// Skip Button of Helper Screen
              _buildSkipButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextView(BuildContext context) {
    return Center(
      child: Text(
        TextConstant.helperTextView,
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
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesName.homeScreen, (route) => false);
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
