import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.isObscure = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 12),
        ],
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: AppColors.hintColor,
            ),
            fillColor: AppColors.white,
            filled: true,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.white, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
