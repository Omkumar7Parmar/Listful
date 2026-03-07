import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/auth_provider.dart' as CustomAuthProvider;

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<CustomAuthProvider.AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : authProvider.errorMessage != null
              ? Center(child: Text('Error: ${authProvider.errorMessage}'))
              : user == null
                  ? const Center(child: Text('No user logged in.'))
                  : ListView(
                      children: [
                        const SizedBox(height: 20),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            user.displayName?.substring(0, 1).toUpperCase() ?? user.email!.substring(0, 1).toUpperCase(),
                            style: const TextStyle(fontSize: 50, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            user.displayName ?? 'N/A',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.email),
                                  title: const Text('Email'),
                                  subtitle: Text(user.email ?? 'N/A'),
                                ),
                                // You can add more profile details here
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.person),
                                  title: const Text('UID'),
                                  subtitle: Text(user.uid),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}
