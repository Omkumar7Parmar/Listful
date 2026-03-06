import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
final _form = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('SignUp ', style: TextStyle(fontSize: 30,),),),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Form(
          key: _form,
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
                }
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
                  onPressed: (){
                    if(_form.currentState!.validate()){
                      _auth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text
                      );
                      Navigator.pushNamed(context, '/task-list');
                    }
                  },
                  child: Text("Signup", style: TextStyle(fontSize: 20, color: Colors.black),),
              ),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, '/login');
              }, child: Text("Login"))
            ]
          )
        ),
      )
    );
  }
}
