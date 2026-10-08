import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/model/theme/AppTheme.dart';
import 'package:evently_task/provider/theme_provider.dart';
import 'package:evently_task/ui/sign_up/sign_up_screen.dart';
import 'package:evently_task/ui/start_screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) =>ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: provider.themeMode,

      routes: {
        RoutesManager.start: (context) => StartScreen(),
        RoutesManager.signup: (context) => SignUpScreen(),
      },
      initialRoute: RoutesManager.start,
    );
  }
}
