import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_state.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSectionWidget extends StatelessWidget {
  final List<Category>? categories;
  final VoidCallback? onViewAllPressed;

  const CategoriesSectionWidget({
    super.key,
    this.categories,
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
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
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
            if (state.categoriesApi.isSuccess) {
              var list = state.categoriesApi.data ?? [];
              return SizedBox(
                height: 240,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(category: list[index]);
                  },
                ),
              );
            } else if (state.categoriesApi.hasError) {
              return Text(state.categoriesApi.errorMessage, style: TextStyle(color: Colors.red));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
