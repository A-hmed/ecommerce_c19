import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/login/cubit/login_cubit.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/login/cubit/login_state.dart';
import 'package:ecommerce_c19/features/common/widgets/app_button.dart';
import 'package:ecommerce_c19/features/common/widgets/app_text_field.dart';
import 'package:ecommerce_c19/features/common/widgets/route_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController(
    text: "ahmedc19@gmail.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "Ahmed@123",
  );
  bool _isPasswordObscured = true;
  LoginCubit cubit = getIt();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.loginApi.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.loginApi.errorMessage),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state.loginApi.isSuccess) {
          Navigator.pushReplacement(context, AppRouter.mainScreen);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Route Logo
                const Center(child: RouteLogo(width: 237, height: 71)),
                const SizedBox(height: 40),
                // Welcome Header
                const Text(
                  'Welcome Back To Route',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please sign in with your mail',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // User Name Field
                AppTextField(
                  label: 'User Name',
                  hintText: 'enter your name',
                  controller: _userNameController,
                ),
                const SizedBox(height: 28),
                // Password Field
                AppTextField(
                  label: 'Password',
                  hintText: 'enter your password',
                  controller: _passwordController,
                  isObscure: _isPasswordObscured,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.hintColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Forgot Password Text Button
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 56),
                // Login Button
                buildLoginButton(),
                const SizedBox(height: 32),
                // Create Account Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AppRouter.register);
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: cubit,
      builder: (context, state) {
        return AppButton(
          text: 'Login',
          isLoading: state.loginApi.isLoading,
          onPressed: () {
            cubit.login(_userNameController.text, _passwordController.text);
          },
        );
      },
    );
  }
}
