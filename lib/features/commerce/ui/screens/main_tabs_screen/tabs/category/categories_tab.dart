import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/cubit/categories_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/widgets/categories_list_widget.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/widgets/sub_categories_section_widget.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/search_with_cart_header.dart';
import 'package:ecommerce_c19/features/common/widgets/route_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  final CategoriesCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Route Logo
              RouteLogo(
                width: 66,
                height: 22,
                color: AppColors.primary,
              ),
              SizedBox(height: 16),

              // 2. Search bar with Cart icon
              SearchWithCartHeader(),
              SizedBox(height: 16),

              // 3. Divided into 2 widgets: Categories List & Sub Categories
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left sidebar widget: Categories list
                    CategoriesListWidget(),
                    SizedBox(width: 16),
                    // Right content widget: Subcategories
                    Expanded(
                      child: SubCategoriesSectionWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
