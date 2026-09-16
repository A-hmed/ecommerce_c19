import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/cubit/categories_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/cubit/categories_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/widgets/category_banner_card.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/widgets/sub_category_grid_item.dart';
import 'package:ecommerce_c19/features/common/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesSectionWidget extends StatelessWidget {
  const SubCategoriesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final selectedCategory = state.selectedCategory;
        if (selectedCategory == null) {
          return const SizedBox.shrink();
        }

        return CustomScrollView(
          slivers: [
            // Category Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  selectedCategory.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),

            // Banner Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CategoryBannerCard(
                  category: selectedCategory,
                  onShopNowPressed: () {
                    Navigator.push(
                      context,
                      AppRouter.productsScreen(
                        categoryId: selectedCategory.id,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Subcategories Content
            if (state.subCategoriesApi.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              )
            else if (state.subCategoriesApi.hasError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorView(
                  message: state.subCategoriesApi.errorMessage.isNotEmpty
                      ? state.subCategoriesApi.errorMessage
                      : 'Failed to load subcategories',
                  onRetry: () => context
                      .read<CategoriesCubit>()
                      .getSubCategories(selectedCategory.id),
                ),
              )
            else if ((state.subCategoriesApi.data ?? []).isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No subcategories found',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            else
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final subCategory = state.subCategoriesApi.data![index];
                    return SubCategoryGridItem(
                      subCategory: subCategory,
                      fallbackImageUrl: selectedCategory.image,
                      onTap: () {
                        Navigator.push(
                          context,
                          AppRouter.productsScreen(
                            categoryId: selectedCategory.id,
                            subCategoryId: subCategory.id,
                          ),
                        );
                      },
                    );
                  },
                  childCount: state.subCategoriesApi.data!.length,
                ),
              ),
          ],
        );
      },
    );
  }
}
