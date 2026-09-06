import 'package:ecommerce_c19/core/di/di.dart';
import 'package:ecommerce_c19/core/routes/app_router.dart';
import 'package:ecommerce_c19/core/theme/colors.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/register/cubit/register_cubit.dart';
import 'package:ecommerce_c19/features/auth/ui/screens/register/cubit/register_state.dart';
import 'package:ecommerce_c19/features/common/widgets/app_button.dart';
import 'package:ecommerce_c19/features/common/widgets/app_text_field.dart';
import 'package:ecommerce_c19/features/common/widgets/route_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  final RegisterCubit cubit = getIt<RegisterCubit>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.registerApi.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.registerApi.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state.registerApi.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
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
                const SizedBox(height: 30),
                // Route Logo
                const Center(
                  child: RouteLogo(
                    width: 237,
                    height: 71,
                  ),
                ),
                const SizedBox(height: 30),
                // Full Name Field
                AppTextField(
                  label: 'Full Name',
                  hintText: 'enter your full name',
                  controller: _fullNameController,
                ),
                const SizedBox(height: 20),
                // Mobile Number Field
                AppTextField(
                  label: 'Mobile Number',
                  hintText: 'enter your mobile no.',
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                // Email Field
                AppTextField(
                  label: 'E-mail address',
                  hintText: 'enter your email address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 40),
                // Sign Up Button
                buildSignUpButton(),
                const SizedBox(height: 24),
                // Already have an account link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
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

  Widget buildSignUpButton() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: cubit,
      builder: (context, state) {
        return AppButton(
          text: 'Sign Up',
          isLoading: state.registerApi.isLoading,
          onPressed: () {
            cubit.register(
              name: _fullNameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              rePassword: _passwordController.text,
              phone: _mobileNumberController.text,
            );
          },
        );
      },
    );
  }
}
