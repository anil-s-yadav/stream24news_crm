import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/shared_preferences.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStoragePref.instance!.initPrefBox();
  try {
    //  Always initialize Firebase directly
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final isLoggedIn = LocalStoragePref.instance?.getLoginBool() ?? false;

    runApp(MyApp(isLoggedIn: isLoggedIn));
  } catch (e, stackTrace) {
    log('Firebase initialization error: $e', stackTrace: stackTrace);
    runApp(const ErrorApp());
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream24 News CRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Error initializing application.\nPlease check your connection and refresh.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream24 News CRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(),
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
