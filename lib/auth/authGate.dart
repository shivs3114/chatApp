import 'package:chatapp/auth/login_or_reg.dart';
import 'package:chatapp/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // User is signed in
            return HomePage(); // Replace with your home page widget
          } else {
            // User is not signed in
            return LoginOrReg(); // Replace with your login page widget
          }
        },
      ),
    );
  }
}