import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/widgets/category_sidebar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSidebar extends StatelessWidget {
  const CategoriesSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          buildWhen: (previous, current) =>
              previous.categoriesApi != current.categoriesApi ||
              previous.selectedCategory != current.selectedCategory,
          builder: (context, state) {
            if (state.categoriesApi.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state.categoriesApi.hasError) {
              final error = state.categoriesApi.errorMessage.isNotEmpty
                  ? state.categoriesApi.errorMessage
                  : 'Failed to load';
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        onPressed: () =>
                            context.read<CategoriesCubit>().loadCategories(),
                      ),
                    ],
                  ),
                ),
              );
            }

            final categories = state.categoriesApi.data ?? [];
            if (categories.isEmpty) {
              return const Center(
                child: Text(
                  'No categories',
                  style: TextStyle(fontSize: 12, color: AppColors.grey),
                ),
              );
            }

            return ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.transparent,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = state.selectedCategory?.id == category.id;
                return CategorySidebarItem(
                  category: category,
                  isSelected: isSelected,
                  onTap: () =>
                      context.read<CategoriesCubit>().selectCategory(category),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
