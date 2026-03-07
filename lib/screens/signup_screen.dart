import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/task_list_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F7F8),
        appBar: AppBar(
          title: const Center(
            child: Text('Create Account',
                style: TextStyle(fontSize: 30)),
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
                      Text("Join Listful", style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                      const Spacer(),
                      Text("Simplify your productivity. Create an account to start managing tasks.", style: GoogleFonts.inter(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Name', hintText: 'John Doe', prefixIcon: SvgPicture.asset('assets/icons/pfp.svg', fit: BoxFit.none, height: 16, width: 16,), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)) ),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email', hintText: 'example@gmail.com', prefixIcon: SvgPicture.asset('assets/icons/mail.svg', fit: BoxFit.none, height: 16, width: 16,), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)) ),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password', hintText: 'Create a Password', prefixIcon: SvgPicture.asset('assets/icons/password.svg',fit: BoxFit.none, height: 16, width: 16,), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)) ),
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
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(labelText: 'Confirm Password', hintText: 'Confirm Your Password', prefixIcon: SvgPicture.asset('assets/icons/confirmPassword.svg',fit: BoxFit.none, height: 16, width: 16,), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)) ),
                          style: const TextStyle(fontSize: 20, color: Colors.black),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
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
                                  await authProvider.signUp(
                                    _emailController.text,
                                    _passwordController.text,
                                    _nameController.text, // Pass the display name
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
                                "Signup",
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
                      Text("Already have an account?", style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }, child: const Text("Login", style: TextStyle(fontSize: 20, color: Color(0xff2094F3)),),)
                    ]
                )
              ],
            ),
          ),
        )
    );
  }
}
