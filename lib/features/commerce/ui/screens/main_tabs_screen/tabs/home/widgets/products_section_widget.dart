import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsSectionWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;

  const ProductsSectionWidget({
    super.key,
    this.title = 'Home Appliance',
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            if (onViewAllPressed != null)
              InkWell(
                onTap: onViewAllPressed,
                child: const Text(
                  'view all',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.productsApi.isSuccess) {
              var list = state.productsApi.data ?? [];
              return SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return ProductCardItem(product: list[index]);
                  },
                ),
              );
            } else if (state.productsApi.hasError) {
              return Center(child: Text(state.productsApi.errorMessage, style: TextStyle(color: Colors.red),));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
