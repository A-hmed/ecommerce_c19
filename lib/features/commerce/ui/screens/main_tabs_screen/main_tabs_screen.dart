import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/categories_tab.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/home_tab.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/profile/profile_tab.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/wishlist/wishlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _selectedIndex = 0;
  CartCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.getCart();
  }

  final List<Widget> _tabs = const [
    HomeTab(),
    CategoriesTab(),
    WishlistTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined, color: AppColors.white),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: const Icon(Icons.home_outlined, color: AppColors.primary),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.grid_view, color: AppColors.white),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: const Icon(Icons.grid_view, color: AppColors.primary),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_outline, color: AppColors.white),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: const Icon(Icons.favorite_outline, color: AppColors.primary),
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline, color: AppColors.white),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: const Icon(Icons.person_outline, color: AppColors.primary),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
