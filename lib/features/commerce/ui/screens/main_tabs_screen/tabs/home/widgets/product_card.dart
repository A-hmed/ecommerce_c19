import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_cubit.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_state.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/widgets/qty_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, AppRouter.productDetails(product));
      },
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image & Heart Icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(13),
                  ),
                  child: product.imageCover.isNotEmpty
                      ? Image.network(
                          product.imageCover,
                          height: 110,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 110,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        )
                      : Container(
                          height: 110,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'EGP ${product.price}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Review (${product.ratingsAverage})',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  buildAddToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddToCartButton() {
    var cubit = getIt<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        Product? cartProduct = state.getProductFromCart(product.id);
        if (state.cartState.isLoading && state.productIds.contains(product.id)) {
          return Row(
            children: [
              Expanded(
                child: QtyControlWidget(
                  qty: cartProduct?.cartQuantity.toInt() ?? 0,
                  onPlusClick: null,
                  onMinusClick: null,
                ),
              ),
            ],
          );
        }

        return cartProduct == null
            ? InkWell(
                onTap: () {
                  cubit.addProductToCart(product.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(Icons.add, color: AppColors.white, size: 18),
                ),
              )
            : Row(
              children: [
                Expanded(
                  child: QtyControlWidget(
                      qty: cartProduct!.cartQuantity.toInt(),
                      onPlusClick: (qty) {
                        cubit.updateProductQty(
                          product.id,
                          cartProduct!.cartQuantity.toInt() + 1,
                        );
                      },
                      onMinusClick: (qty) {
                        cubit.updateProductQty(
                          product.id,
                          cartProduct!.cartQuantity.toInt() - 1,
                        );
                      },
                    ),
                ),
              ],
            );
      },
    );
  }
}
