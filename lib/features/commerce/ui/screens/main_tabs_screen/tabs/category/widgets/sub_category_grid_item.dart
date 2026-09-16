import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/sub_category.dart';
import 'package:flutter/material.dart';

class SubCategoryGridItem extends StatelessWidget {
  final SubCategory subCategory;
  final String fallbackImageUrl;
  final VoidCallback? onTap;

  const SubCategoryGridItem({
    super.key,
    required this.subCategory,
    this.fallbackImageUrl = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveImageUrl =
        subCategory.image.isNotEmpty ? subCategory.image : fallbackImageUrl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image Container
          Container(
            width: 70,
            height: 70,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
            child: effectiveImageUrl.isNotEmpty &&
                    effectiveImageUrl.startsWith('http')
                ? Image.network(
                    effectiveImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.category_outlined,
                      size: 28,
                      color: AppColors.primary,
                    ),
                  )
                : const Icon(
                    Icons.category_outlined,
                    size: 28,
                    color: AppColors.primary,
                  ),
          ),
          const SizedBox(height: 6),
          // Title
          Text(
            subCategory.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
