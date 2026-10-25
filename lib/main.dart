import 'package:easy_localization/easy_localization.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/model/theme/AppTheme.dart';
import 'package:evently_task/provider/theme_provider.dart';
import 'package:evently_task/provider/user_provider.dart';
import 'package:evently_task/services/fcm_service.dart';
import 'package:evently_task/ui/add_event/add_event_screen.dart';
import 'package:evently_task/ui/home_screen/screen/home_screen.dart';
import 'package:evently_task/ui/login/screen/login_screen.dart';
import 'package:evently_task/ui/on_boarding/on_boarding.dart';
import 'package:evently_task/ui/sign_up/sign_up_screen.dart';
import 'package:evently_task/ui/start_screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmService.init();
  await EasyLocalization.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  final prefs=await SharedPreferences.getInstance();
  final bool isCompleted= prefs.getBool('onboarding_completed')??false;

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: EasyLocalization(
        supportedLocales: [
          Locale("en"),
          Locale("ar")
        ],
        path: 'assets/translations',
        child: MyApp(
          initialRoute: isCompleted?

          FirebaseAuth.instance.currentUser!=null?
          RoutesManager.homeScreen
              :
          RoutesManager.signup
              :
          RoutesManager.start
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: provider.themeMode,

      routes: {
        RoutesManager.start: (context) => StartScreen(),
        RoutesManager.signup: (context) => SignUpScreen(),
        RoutesManager.login: (context) => Login(),
        RoutesManager.homeScreen: (context) => ChangeNotifierProvider(
          create: (BuildContext context) => UserProvider()..setUserValue(),
          child: HomeScreen(),
        ),
        RoutesManager.addEvent: (context) => AddEventScreen(),
        RoutesManager.onBoarding: (context) => OnBoarding(),
      },
      initialRoute: initialRoute
    );
  }
}
