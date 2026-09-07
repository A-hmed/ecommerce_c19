import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final Category category;

  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.1),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: category.image.isNotEmpty &&
              category.image.startsWith('http')
              ? Image.network(
            category.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.category_outlined,
              size: 32,
              color: AppColors.primary,
            ),
          )
              : const Icon(
            Icons.category_outlined,
            size: 32,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
