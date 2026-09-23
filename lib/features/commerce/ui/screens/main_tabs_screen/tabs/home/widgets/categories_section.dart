import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.categoriesApi.isSuccess) {
          return buildCategoriesView(context, state.categoriesApi.data!);
        } else if (state.categoriesApi.hasError) {
          return SizedBox.shrink();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  buildCategoriesView(BuildContext context, List<Category> categories) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'view all',
              style: TextStyle(fontSize: 14, color: AppColors.primary),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: MediaQuery.of(context).size.height * .24,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            return CategoryItem(category: categories[index]);
          },
        ),
      ),
    ],
  );
}
