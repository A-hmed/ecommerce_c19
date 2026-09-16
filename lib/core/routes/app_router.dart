import 'package:ecommerce_c19/features/auth/ui/screens/login/login_screen.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/register/register_screen.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/main_tabs_screen.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/products_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRouter {
  static MaterialPageRoute get login =>
      MaterialPageRoute(builder: (_) => const LoginScreen());

  static MaterialPageRoute get register =>
      MaterialPageRoute(builder: (_) => const RegisterScreen());

  static MaterialPageRoute get mainScreen =>
      MaterialPageRoute(builder: (_) => const MainTabsScreen());

  static MaterialPageRoute productsScreen({
    String? categoryId,
    String? subCategoryId,
  }) =>
      MaterialPageRoute(
        builder: (_) => ProductsScreen(
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
      );
}
