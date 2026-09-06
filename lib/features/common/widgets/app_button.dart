import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double? height;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.primary,
    this.borderRadius = 15,
    this.height = 64,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? AppColors.grey: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        onPressed: isLoading ? (){} : onPressed,
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
      ),
    );
  }
}
