import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/product_card_item.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/search_with_cart_header.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/cubit/products_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/cubit/products_state.dart';
import 'package:ecommerce_c19/features/common/widgets/error_view.dart';
import 'package:ecommerce_c19/features/common/widgets/route_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  final String? categoryId;
  final String? subCategoryId;

  const ProductsScreen({
    super.key,
    this.categoryId,
    this.subCategoryId,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.getProducts(
      category: widget.categoryId,
      subCategory: widget.subCategoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Back button (if navigable) + Route Logo
                Row(
                  children: [
                    if (Navigator.canPop(context))
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primary,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    if (Navigator.canPop(context)) const SizedBox(width: 8),
                    const RouteLogo(
                      width: 66,
                      height: 22,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Bar with Cart
                const SearchWithCartHeader(),
                const SizedBox(height: 16),

                // 2-Column Product Grid
                Expanded(
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      if (state.productsApi.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }

                      if (state.productsApi.hasError) {
                        return ErrorView(
                          message: state.productsApi.errorMessage.isNotEmpty
                              ? state.productsApi.errorMessage
                              : 'Failed to load products',
                          onRetry: () => cubit.getProducts(
                            category: widget.categoryId,
                            subCategory: widget.subCategoryId,
                          ),
                        );
                      }

                      final products = state.productsApi.data ?? [];
                      if (products.isEmpty) {
                        return const Center(
                          child: Text(
                            'No products found',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: products.length,
                        padding: const EdgeInsets.only(bottom: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCardItem(product: products[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
