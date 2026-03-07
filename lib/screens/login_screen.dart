import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;
import 'package:task_manager/screens/task_list_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:task_manager/widgets/custom_button.dart';

final _form1 = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Login', style: TextStyle(fontSize: 30,),)),
          backgroundColor: Colors.orange,
        ),
        body: Center(
            child: Form(
                key: _form1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          style: const TextStyle(fontSize: 20, color: Colors.black),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          }
                      ),
                      const SizedBox(height: 20),
                      Consumer<CustomAuthProvider.AuthProvider>(
                        builder: (context, authProvider, child) {
                          return authProvider.isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () async {
                              if(_form1.currentState!.validate()){
                                await authProvider.signIn(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (authProvider.errorMessage == null) {
                                  if (context.mounted) {
                                    Navigator.of(context).pushReplacementNamed(TaskListScreen.routeName);
                                  }
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(authProvider.errorMessage!)),
                                    );
                                  }
                                }
                              }
                            },
                            child: const Text("Login"),
                          );
                        },
                      ),
                    ]
                )
            )
        )
    );
  }
}