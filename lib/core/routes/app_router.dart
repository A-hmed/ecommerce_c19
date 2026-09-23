import 'package:ecommerce_c19/features/auth/ui/screens/login/login_screen.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/register/register_screen.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/main_tabs_screen.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/products_screen.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/product_details_screen/product_details_screen.dart';
import 'package:ecommerce_c19/features/cart/ui/screens/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRouter {
  static MaterialPageRoute get login =>
      MaterialPageRoute(builder: (_) => const LoginScreen());

  static MaterialPageRoute get register =>
      MaterialPageRoute(builder: (_) => const RegisterScreen());

  static MaterialPageRoute get mainScreen =>
      MaterialPageRoute(builder: (_) => MainTabsScreen());

  static MaterialPageRoute get cart =>
      MaterialPageRoute(builder: (_) => const CartScreen());

  static MaterialPageRoute products(Category category, Category? subCategory) =>
      MaterialPageRoute(
        builder: (_) => ProductsScreen(
          category: category,
          subCategory: subCategory,
        ),
      );

  static MaterialPageRoute productDetails(Product product) =>
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: product),
      );
}
