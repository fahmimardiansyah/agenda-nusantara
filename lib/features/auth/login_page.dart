import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';

import '../../core/utils/app_page_transition.dart';

import '../../data/services/auth_service.dart';

import '../navigation/main_navigation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {
  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  Future<void> login() async {
    final username =
        usernameController.text.trim();

    final password =
        passwordController.text.trim();

    final success =
        await AuthService.login(
      username,
      password,
    );

    if (success) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,

        AppPageTransition(
          page:
              const MainNavigationPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
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
      backgroundColor:
          AppColors.background,

      body: Stack(
        children: [
          // =========================
          // BACKGROUND IMAGE
          // =========================
          Positioned.fill(
            child: Image.asset(
              'assets/images/login-bg.jpg',

              fit: BoxFit.cover,
            ),
          ),

          // =========================
          // DARK OVERLAY
          // =========================
          Positioned.fill(
            child: Container(
              color:
                  Colors.black.withOpacity(
                0.45,
              ),
            ),
          ),

          // =========================
          // CONTENT
          // =========================
          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                AppSizes.xl,
              ),

              child: SizedBox(
                height:
                    MediaQuery.of(
                      context,
                    ).size.height *
                    0.9,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    const Spacer(),

                    // =========================
                    // TITLE
                    // =========================
                    const Text(
                      'Agenda\nNusantara',

                      style: TextStyle(
                        fontSize: 42,
                        fontWeight:
                            FontWeight
                                .bold,

                        height: 1.1,
                      ),
                    ),

                    const SizedBox(
                      height: AppSizes.md,
                    ),

                    const Text(
                      'Modern productivity app with futuristic experience 🚀',

                      style: TextStyle(
                        color:
                            Colors.white70,

                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    // =========================
                    // LOGIN CARD
                    // =========================
                    Container(
                      padding:
                          const EdgeInsets.all(
                        AppSizes.xl,
                      ),

                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(
                          0.05,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          32,
                        ),

                        border: Border.all(
                          color: Colors.white
                              .withOpacity(
                            0.08,
                          ),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .black
                                .withOpacity(
                              0.25,
                            ),

                            blurRadius: 24,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          // USERNAME
                          CustomTextField(
                            controller:
                                usernameController,

                            hintText:
                                'Username',

                            prefixIcon:
                                Icons.person,
                          ),

                          const SizedBox(
                            height:
                                AppSizes.lg,
                          ),

                          // PASSWORD
                          CustomTextField(
                            controller:
                                passwordController,

                            hintText:
                                'Password',

                            prefixIcon:
                                Icons.lock,

                            obscureText:
                                true,
                          ),

                          const SizedBox(
                            height:
                                AppSizes.xxl,
                          ),

                          // LOGIN BUTTON
                          CustomButton(
                            text: 'Login',

                            onPressed: login,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}