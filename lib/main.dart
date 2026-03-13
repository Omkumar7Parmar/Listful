import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/signup_screen.dart';
import 'package:task_manager/screens/task_list_screen.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';

import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;
import 'package:task_manager/providers/task_provider.dart';

import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/services/firestore_service.dart';
import 'firebase_options.dart';

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
    final authService = AuthService();
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomAuthProvider.AuthProvider(authService)),
        ChangeNotifierProxyProvider<CustomAuthProvider.AuthProvider, TaskProvider>(
          create: (_) => TaskProvider(firestoreService),
          update: (context, auth, previousTaskProvider) {
            previousTaskProvider!.updateUser(auth.listfulUser?.uid);
            return previousTaskProvider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<CustomAuthProvider.AuthProvider>(
          builder: (context, auth, _) {
            if (auth.isLoading && auth.listfulUser == null) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (auth.listfulUser != null) {
              return const TaskListScreen();
            }
            return const LoginScreen();
          },
        ),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          TaskListScreen.routeName: (context) => const TaskListScreen(),
          AddTaskScreen.routeName: (context) => const AddTaskScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
