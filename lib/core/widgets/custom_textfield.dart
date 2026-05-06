import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,

      style: const TextStyle(
        color: AppColors.white,
      ),

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: const TextStyle(
          color: AppColors.grey,
        ),

        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.grey,
              )
            : null,

        filled: true,
        fillColor: AppColors.card,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}