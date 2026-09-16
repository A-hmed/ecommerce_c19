import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final Category subCategory;
  final VoidCallback? onTap;

  const SubCategoryItem({
    super.key,
    required this.subCategory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary.withValues(alpha: 0.08),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: subCategory.image != null && subCategory.image!.isNotEmpty
                ? Image.network(
                    subCategory.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      child: const Icon(
                        Icons.category_outlined,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                  )
                : Container(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    child: const Icon(
                      Icons.category_outlined,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 74,
          child: Text(
            subCategory.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
        ),
      ],
    ),
    );
  }
}
