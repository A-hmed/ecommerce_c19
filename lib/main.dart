import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/shared_pref_utils/shared_pref_utils.dart';
import 'package:ecommerce_c19/core/theme/app_theme.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/login/login_screen.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_cubit.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/main_tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Widget -> ViewModel -> Usecase -> Repository -> RemoteDataSource
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  SharedPrefUtils prefUtils = getIt();
  String? token = await prefUtils.getToken();
  runApp(BlocProvider(
      create: (_) => getIt<CartCubit>(),
      child: MyApp(isLoggedIn: token?.isNotEmpty ?? false)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, this.isLoggedIn = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isLoggedIn ? const MainTabsScreen() : const LoginScreen(),
    );
  }
}
