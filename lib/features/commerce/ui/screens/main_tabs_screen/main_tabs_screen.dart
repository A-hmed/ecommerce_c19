import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/categories_tab.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/home/home_tab.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/profile/profile_tab.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/wishlist/wishlist_tab.dart';
import 'package:flutter/material.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    CategoriesTab(),
    WishlistTab(),
    ProfileTab(),
  ];

  Widget _buildActiveIcon(IconData iconData) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: AppColors.primary,
        size: 24,
      ),
    );
  }

  Widget _buildUnselectedIcon(IconData iconData) {
    return Icon(
      iconData,
      color: AppColors.white,
      size: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.primary,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            elevation: 0,
            backgroundColor: AppColors.primary,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: _buildUnselectedIcon(Icons.home_outlined),
                activeIcon: _buildActiveIcon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildUnselectedIcon(Icons.grid_view_outlined),
                activeIcon: _buildActiveIcon(Icons.grid_view_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: _buildUnselectedIcon(Icons.favorite_outline),
                activeIcon: _buildActiveIcon(Icons.favorite_outline),
                label: 'WishList',
              ),
              BottomNavigationBarItem(
                icon: _buildUnselectedIcon(Icons.person_outline),
                activeIcon: _buildActiveIcon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
