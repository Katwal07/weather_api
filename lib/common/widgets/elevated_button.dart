import 'package:flutter/material.dart';

import '../../core/config/theme/colors.dart';
import '../../core/utils/res/resolution.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.57 * AppResolution.heightMultiplier,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.grey,
          disabledForegroundColor: AppColors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              3 * AppResolution.widthMultiplier,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color:AppColors.white),
        ),
      ),
    );
  }
}
