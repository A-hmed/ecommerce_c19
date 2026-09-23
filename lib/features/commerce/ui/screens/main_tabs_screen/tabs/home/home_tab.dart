import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/cubit/home_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/ads_section.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/categories_section.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/home_header.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/widgets/products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _cubit = getIt<HomeCubit>();

  static const List<Map<String, dynamic>> _mockAds = [
    {
      'title': 'UP TO\n25% OFF',
      'subtitle': 'For all Headphones\n& AirPods',
      'bgColor': Color(0xFFF9C70C),
      'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    },
    {
      'title': 'UP TO\n30% OFF',
      'subtitle': 'On Selected Women\'s\nFashion items',
      'bgColor': Color(0xFFFFB74D),
      'imageUrl': 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=500',
    },
    {
      'title': 'SPECIAL\nOFFER',
      'subtitle': 'Latest Laptops &\nElectronics deals',
      'bgColor': Color(0xFF81D4FA),
      'imageUrl': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
    },
  ];

  @override
  void initState() {
    super.initState();
    _cubit.loadHomeData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: 20),
              const AdsSection(ads: _mockAds),
              const SizedBox(height: 24),
              CategoriesSection(),
              const SizedBox(height: 24),
              ProductsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
