import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/screens/task_list_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:task_manager/widgets/custom_button.dart';

final _form1 = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;
final _emailController = TextEditingController();
final _passwordController = TextEditingController();



class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Login', style: TextStyle(fontSize: 30,),)),
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
                style: TextStyle(fontSize: 20, color: Colors.black),
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
                style: TextStyle(fontSize: 20, color: Colors.black),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                }
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if(_form1.currentState!.validate()){
                      try {
                        await _auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                        );
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TaskListScreen()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        String message;
                        if (e.code == 'user-not-found') {
                          message = 'No user found for that email.';
                        } else if (e.code == 'wrong-password') {
                          message = 'Wrong password provided for that user.';
                        } else {
                          message = e.message ?? 'An unknown error occurred.';
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('An error occurred: ${e.toString()}')),
                          );
                        }
                      }
                    }
                  },
                  child: Text("Login")),
            ]
          )
        )
      )
    );
  }
}