import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;
import 'package:task_manager/screens/signup_screen.dart';
import 'package:task_manager/screens/task_list_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7F8),
      appBar: AppBar(
        title: const Center(
          child: Text('Login', style: TextStyle(fontSize: 30)),
        ),
        backgroundColor: const Color(0xffF5F7F8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 96,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Sign in to continue managing your tasks.",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      // Making height adaptable by removing fixed value
                      padding: const EdgeInsets.only(bottom: 8.0), // Space for error message
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          prefixIcon: SvgPicture.asset('assets/icons/mail.svg', fit: BoxFit.none, height: 16, width: 16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                        ),
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      // Making height adaptable
                      padding: const EdgeInsets.only(bottom: 8.0), // Space for error message
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: SvgPicture.asset('assets/icons/password.svg', fit: BoxFit.none, height: 16, width: 16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                        ),
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Consumer<CustomAuthProvider.AuthProvider>(
                      builder: (context, authProvider, child) {
                        return SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff2094F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: authProvider.isLoading ? null : () async {
                              if (_formKey.currentState!.validate()) {
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
                            child: authProvider.isLoading
                                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                : const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(fontSize: 20, color: Color(0xff2094F3)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
