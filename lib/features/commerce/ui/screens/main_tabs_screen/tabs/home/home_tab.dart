import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/ads_carousel_widget.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/categories_section_widget.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/products_section_widget.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/search_with_cart_header.dart';
import 'package:ecommerce_c19/features/common/widgets/route_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeCubit cubit = getIt();
  @override
  void initState() {
    super.initState();
    cubit.getProducts();
    cubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // 1. AppBar Route Logo at leading
              RouteLogo(
                width: 66,
                height: 22,
                color: AppColors.primary,
              ),
              SizedBox(height: 16),

              // 2. Search bar with Cart icon
              SearchWithCartHeader(),
              SizedBox(height: 16),

              // 3. Ads Carousel Slider
              AdsCarouselWidget(),
              SizedBox(height: 20),

              // 4. Categories Grid
              CategoriesSectionWidget(),
              SizedBox(height: 20),

              // 5. Products Horizontal List
              ProductsSectionWidget(title: 'Home Appliance'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
