import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/database/database_helper.dart';
import 'features/auth/login_page.dart';
import 'data/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.initUser();

  await DatabaseHelper.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agenda Nusantara',
        theme: AppTheme.darkTheme,
        home: const LoginPage(),
      ),
    );
  }
}
