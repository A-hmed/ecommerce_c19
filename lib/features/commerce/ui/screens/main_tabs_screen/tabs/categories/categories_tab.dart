import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/widgets/categories_sidebar.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/widgets/sub_categories_section.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  final _cubit = getIt<CategoriesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesSidebar(),
                    SizedBox(width: 16),
                    Expanded(
                      child: SubCategoriesSection(),
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
