import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;
import 'package:task_manager/screens/task_list_screen.dart';

final _form = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  const SignupScreen({super.key});

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 96,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
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
            Container(
              height: 388,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 24, right: 24),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xff94A3B8),),borderRadius: BorderRadius.circular(12.0)),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name', hintText: 'John Doe', prefixIcon: SvgPicture.asset('assets/icons/pfp.svg', fit: BoxFit.none, height: 16, width: 16,), border: InputBorder.none ),
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
                    const Spacer(),
                    Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xff94A3B8),),borderRadius: BorderRadius.circular(12.0)),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email', hintText: 'example@gmail.com', prefixIcon: SvgPicture.asset('assets/icons/mail.svg', fit: BoxFit.none, height: 16, width: 16,), border: InputBorder.none ),
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xff94A3B8),),borderRadius: BorderRadius.circular(12.0)),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password', hintText: 'Create a Password', prefixIcon: SvgPicture.asset('assets/icons/password.svg',fit: BoxFit.none, height: 16, width: 16,), border: InputBorder.none ),
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
                    const Spacer(),
                    Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xff94A3B8),),borderRadius: BorderRadius.circular(12.0)),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(labelText: 'Confirm Password', hintText: 'Confirm Your Password', prefixIcon: SvgPicture.asset('assets/icons/confirmPassword.svg',fit: BoxFit.none, height: 16, width: 16,), border: InputBorder.none ),
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
                    const Spacer(),
                    Consumer<CustomAuthProvider.AuthProvider>(
                      builder: (context, authProvider, child) {
                        return Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.black38,),borderRadius: BorderRadius.circular(12.0), color: const Color(0xff2094F3)),
                          child: authProvider.isLoading
                              ? const Center(child: CircularProgressIndicator(color: Colors.white))
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: const Color(0xff2094F3),),
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                await authProvider.signUp(
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
                            child: const Text(
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
            ),
            const Spacer(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, '/login');
                  }, child: const Text("Login", style: TextStyle(fontSize: 20, color: Color(0xff2094F3)),),)
                ]
            )
          ],
        )
    );
  }
}