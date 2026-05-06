import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';
import '../navigation/main_navigation_page.dart';
import '../../data/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
  final username = usernameController.text.trim();
  final password = passwordController.text.trim();

  final success = await AuthService.login(
    username,
    password,
  );

  if (success) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainNavigationPage(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Username atau password salah',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Spacer(),

              // LOGO
              Center(
                child: Container(
                  width: 110,
                  height: 110,

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8B5CF6),
                        Color(0xFF6D28D9),
                      ],
                    ),

                    borderRadius: BorderRadius.circular(32),

                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.task_alt_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.xl),

              // TITLE
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Agenda Nusantara',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),

                    SizedBox(height: AppSizes.sm),

                    Text(
                      'Organize your daily productivity',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // USERNAME
              CustomTextField(
                hintText: 'Username',
                controller: usernameController,
                prefixIcon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: AppSizes.md),

              // PASSWORD
              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: true,
              ),

              const SizedBox(height: AppSizes.xl),

              // BUTTON
              CustomButton(
                text: 'Login',
                icon: Icons.arrow_forward_rounded,
                onPressed: login,
              ),

              const SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}