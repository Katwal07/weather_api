import 'package:flutter/material.dart';
import '../../core/config/theme/colors.dart';
import '../../core/utils/res/resolution.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged, this.onSaved,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.57 * AppResolution.heightMultiplier,
      child: TextFormField(
        onSaved: onSaved,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(
              vertical: 2.15 * AppResolution.heightMultiplier,
              horizontal: 2.15 * AppResolution.widthMultiplier),
          prefixIconColor: AppColors.black,
          hintStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppColors.onSurfaceContainerColor),
          border: const OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(
              3 * AppResolution.widthMultiplier,
            ),
            borderSide: BorderSide(width: 1, color: AppColors.black),
          ),
          focusedBorder: const OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(
              3 * AppResolution.widthMultiplier,
            ),
            borderSide: BorderSide(width: 1, color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
