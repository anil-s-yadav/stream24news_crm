import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stream24news_crm/screens/home_screen.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    log('Error initializing app: $e');
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream24 News CRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(),
      home: const LoginScreen(),
    );
  }
}
