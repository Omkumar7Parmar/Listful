import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/signup_screen.dart';
import 'firebase_options.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        '/task-list': (context) => const SignupScreen(),
        '/add-task': (context) => const SignupScreen(),
        '/profile': (context) => const SignupScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}


