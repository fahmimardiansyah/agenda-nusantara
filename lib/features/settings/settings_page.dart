import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';

import '../../data/services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState();
}

class _SettingsPageState
    extends State<SettingsPage> {
  final oldPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  // =========================
  // CHANGE PASSWORD
  // =========================
  Future<void> changePassword() async {
    final oldPassword =
        oldPasswordController.text.trim();

    final newPassword =
        newPasswordController.text.trim();

    if (oldPassword.isEmpty ||
        newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'All fields are required',
          ),
        ),
      );

      return;
    }

    final success =
        await AuthService.changePassword(
      oldPassword,
      newPassword,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password updated successfully',
          ),
        ),
      );

      oldPasswordController.clear();
      newPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Current password is incorrect',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // TITLE
            const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: AppSizes.sm,
            ),

            const Text(
              'Update your account password securely',
              style: TextStyle(
                color: AppColors.grey,
              ),
            ),

            const SizedBox(
              height: AppSizes.xl,
            ),

            // OLD PASSWORD
            CustomTextField(
              hintText: 'Current Password',

              controller:
                  oldPasswordController,

              prefixIcon:
                  Icons.lock_outline_rounded,

              obscureText: true,
            ),

            const SizedBox(
              height: AppSizes.md,
            ),

            // NEW PASSWORD
            CustomTextField(
              hintText: 'New Password',

              controller:
                  newPasswordController,

              prefixIcon:
                  Icons.lock_reset_rounded,

              obscureText: true,
            ),

            const SizedBox(
              height: AppSizes.xl,
            ),

            // BUTTON
            CustomButton(
              text: 'Save Password',

              icon: Icons.save_rounded,

              onPressed: changePassword,
            ),

            const SizedBox(
              height: AppSizes.xxl,
            ),

            // DEVELOPER CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(
                AppSizes.lg,
              ),

              decoration: BoxDecoration(
                color: AppColors.card,

                borderRadius:
                    BorderRadius.circular(
                  AppSizes.cardRadius,
                ),
              ),

              child: Column(
                children: [
                  // PHOTO
                  CircleAvatar(
                    radius: 45,

                    backgroundColor:
                        AppColors.primary,

                    child: const Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(
                    height: AppSizes.lg,
                  ),

                  // NAME
                  const Text(
                    'Fahmi Mardiansyah',

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: AppSizes.xs,
                  ),

                  // NIM
                  const Text(
                    'Politeknik Negeri Malang',

                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(
                    height: AppSizes.xs,
                  ),

                  const Text(
                    'UI/UX & Front-End Developer',

                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}