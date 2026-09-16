import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/cubit/categories_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/cubit/categories_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/widgets/category_sidebar_item.dart';
import 'package:ecommerce_c19/features/common/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state.categoriesApi.isLoading) {
          return const SizedBox(
            width: 136,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }

        if (state.categoriesApi.hasError) {
          return SizedBox(
            width: 136,
            child: ErrorView(
              message: state.categoriesApi.errorMessage.isNotEmpty
                  ? state.categoriesApi.errorMessage
                  : 'Failed to load categories',
              onRetry: () => context.read<CategoriesCubit>().getCategories(),
            ),
          );
        }

        final categories = state.categoriesApi.data ?? [];
        if (categories.isEmpty) {
          return const SizedBox(
            width: 136,
            child: Center(
              child: Text(
                'No categories',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }

        return Container(
          width: 136,
          decoration: BoxDecoration(
            color: const Color(0xFFDBE4ED).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = index == state.selectedCategoryIndex;
              return CategorySidebarItem(
                category: category,
                isSelected: isSelected,
                onTap: () =>
                    context.read<CategoriesCubit>().selectCategory(index),
              );
            },
          ),
        );
      },
    );
  }
}
