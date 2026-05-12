import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_textfield.dart';

import '../../data/services/auth_service.dart';

import '../auth/login_page.dart';

import '../../core/utils/app_page_transition.dart';

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
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          behavior:
              SnackBarBehavior.floating,

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
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Password updated successfully',
          ),
        ),
      );

      oldPasswordController.clear();

      newPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Current password is incorrect',
          ),
        ),
      );
    }
  }

  // =========================
  // HOW TO USE MODAL
  // =========================
  void _showHowToUse() {
    showModalBottomSheet(
      context: context,

      backgroundColor:
          Colors.transparent,

      isScrollControlled: true,

      builder: (_) {
        return Container(
          padding:
              const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: AppColors.card,

            borderRadius:
                const BorderRadius.vertical(
              top: Radius.circular(32),
            ),

            border: Border.all(
              color: Colors.white
                  .withOpacity(0.06),
            ),
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,

                    decoration: BoxDecoration(
                      color: Colors.white24,

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'How To Use 🚀',

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                _buildGuideItem(
                  icon:
                      Icons.add_circle_outline,

                  title: 'Add Task',

                  desc:
                      'Tekan tombol (+) di bawah untuk menambahkan task baru.',
                ),

                _buildGuideItem(
                  icon: Icons.edit_outlined,

                  title: 'Edit Task',

                  desc:
                      'Tekan salah satu task untuk mengedit data task.',
                ),

                _buildGuideItem(
                  icon:
                      Icons.swipe_left_alt_rounded,

                  title: 'Delete Task',

                  desc:
                      'Swipe task ke kiri untuk menghapus task.',
                ),

                _buildGuideItem(
                  icon:
                      Icons.check_circle_outline,

                  title: 'Complete Task',

                  desc:
                      'Tekan checkbox untuk menandai task selesai.',
                ),

                _buildGuideItem(
                  icon:
                      Icons.calendar_month,

                  title: 'Calendar',

                  desc:
                      'Pilih tanggal di calendar untuk melihat task berdasarkan tanggal.',
                ),

                const SizedBox(height: 24),

                const Text(
                  'Task Indicators',

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,

                      decoration:
                          const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      'Important Task',
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,

                      decoration:
                          const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      'Regular Task',
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================
  // GUIDE ITEM
  // =========================
  Widget _buildGuideItem({
    required IconData icon,

    required String title,

    required String desc,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            padding:
                const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color:
                  Colors.white.withOpacity(
                0.05,
              ),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),
            ),

            child: Icon(icon),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,

                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  desc,

                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Settings')),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(
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
                fontWeight:
                    FontWeight.bold,
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
              hintText:
                  'Current Password',

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

            // SAVE BUTTON
            CustomButton(
              text: 'Save Password',

              icon: Icons.save_rounded,

              onPressed: changePassword,
            ),

            const SizedBox(
              height: AppSizes.md,
            ),

            // HOW TO USE BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _showHowToUse,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.card,

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                icon: const Icon(
                  Icons.help_outline_rounded,
                ),

                label: const Text(
                  'How To Use',

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.md,
            ),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () async {
                  await AuthService.logout();

                  if (!mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,

                    AppPageTransition(
                      page:
                          const LoginPage(),
                    ),

                    (route) => false,
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.danger,

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                icon: const Icon(
                  Icons.logout_rounded,
                ),

                label: const Text(
                  'Logout',

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: AppSizes.xxl,
            ),

            // DEVELOPER CARD
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
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

                  // CAMPUS
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
                    'APP Developer',

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