import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../auth/login_page.dart';
import '../../core/utils/app_page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,

        AppPageTransition(page: const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.xl),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // =========================
              // LOGO
              // =========================
              Container(
                width: 140,
                height: 140,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                  ),

                  borderRadius: BorderRadius.circular(40),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),

                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.task_alt_rounded,

                  size: 70,

                  color: Colors.white,
                ),
              ),

              const SizedBox(height: AppSizes.xxl),

              // =========================
              // TITLE
              // =========================
              const Text(
                'Agenda Nusantara',

                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: AppSizes.sm),

              const Text(
                'Modern Productivity App',

                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),

              const SizedBox(height: 80),

              // =========================
              // LOADING
              // =========================
              const CircularProgressIndicator(color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
