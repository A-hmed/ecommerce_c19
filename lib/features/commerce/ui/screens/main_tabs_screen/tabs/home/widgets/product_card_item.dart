import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:flutter/material.dart';

class ProductCardItem extends StatefulWidget {
  final Product product;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onAddPressed;

  const ProductCardItem({
    super.key,
    required this.product,
    this.onFavoritePressed,
    this.onAddPressed,
  });

  @override
  State<ProductCardItem> createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header Area
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: widget.product.imageCover.isNotEmpty &&
                    widget.product.imageCover.startsWith('http')
                    ? Image.network(
                  widget.product.imageCover,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                )
                    : const Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                    if (widget.onFavoritePressed != null) {
                      widget.onFavoritePressed!();
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Product Details Area
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'EGP ${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Review (${widget.product.ratingsAverage})',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: widget.onAddPressed,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
