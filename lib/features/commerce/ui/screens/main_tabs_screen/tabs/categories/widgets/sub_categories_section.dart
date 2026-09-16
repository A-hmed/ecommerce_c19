import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/widgets/category_banner.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/widgets/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesSection extends StatelessWidget {
  const SubCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) =>
          previous.selectedCategory != current.selectedCategory ||
          previous.subCategoriesApi != current.subCategoriesApi,
      builder: (context, state) {
        final selectedCategory = state.selectedCategory;

        if (selectedCategory == null) {
          return const Center(
            child: Text(
              'Select a category',
              style: TextStyle(color: AppColors.grey),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedCategory.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            CategoryBanner(category: selectedCategory),
            const SizedBox(height: 16),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.subCategoriesApi.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  if (state.subCategoriesApi.hasError) {
                    final error = state.subCategoriesApi.errorMessage.isNotEmpty
                        ? state.subCategoriesApi.errorMessage
                        : 'Failed to load subcategories';
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: AppColors.error, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            error,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: AppColors.error),
                          ),
                          const SizedBox(height: 8),
                          IconButton(
                            icon: const Icon(Icons.refresh, color: AppColors.primary),
                            onPressed: () => context
                                .read<CategoriesCubit>()
                                .loadSubCategories(selectedCategory.id),
                          ),
                        ],
                      ),
                    );
                  }

                  final subCategories = state.subCategoriesApi.data ?? [];
                  if (subCategories.isEmpty) {
                    return const Center(
                      child: Text(
                        'No subcategories found',
                        style: TextStyle(fontSize: 12, color: AppColors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: subCategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 115,
                    ),
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return SubCategoryItem(
                        subCategory: subCategory,
                        onTap: () {
                          Navigator.push(
                            context,
                            AppRouter.products(selectedCategory, subCategory),
                          );
                        },
                      );
                    },
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
