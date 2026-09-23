import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/product_card.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/cubit/products_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/cubit/products_state.dart';
import 'package:ecommerce_c19/features/common/widgets/route_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  final Category category;
  final Category? subCategory;

  const ProductsScreen({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _cubit = getIt<ProductsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.loadProducts(
      categoryId: widget.category.id,
      subCategoryId: widget.subCategory?.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button, logo, search bar and cart
                Row(
                  children: [
                    if (Navigator.canPop(context)) ...[
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.primary,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                    const RouteLogo(
                      width: 66,
                      height: 22,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: AppColors.primary,
                              size: 26,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'what do you search for?',
                                  hintStyle: TextStyle(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.6,
                                    ),
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, AppRouter.cart);
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Products Grid
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
                        final error = state.productsApi.errorMessage.isNotEmpty
                            ? state.productsApi.errorMessage
                            : 'Failed to load products';
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                                size: 36,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                error,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.error,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () => _cubit.loadProducts(
                                  categoryId: widget.category.id,
                                  subCategoryId: widget.subCategory?.id,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                ),
                                child: const Text(
                                  'Try Again',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final products = state.productsApi.data ?? [];
                      if (products.isEmpty) {
                        return const Center(
                          child: Text(
                            'No products found in this category',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              mainAxisExtent: 260,
                            ),
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
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
