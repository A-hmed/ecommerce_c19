import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchWithCartHeader extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onCartPressed;

  const SearchWithCartHeader({
    super.key,
    this.onSearchChanged,
    this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'what do you search for?',
              hintStyle: TextStyle(
                color: AppColors.primary.withValues(alpha: 0.6),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primary,
                size: 24,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: onCartPressed,
          borderRadius: BorderRadius.circular(24),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
