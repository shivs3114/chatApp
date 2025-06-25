
import 'package:chatapp/auth/authGate.dart';
import 'package:chatapp/auth/login_or_reg.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart'; // For Navigation (optional)

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to Home Screen
      Get.off(AuthGate());
     // Get.off(() => MyHomePage(title: 'Welcome to Gupshup')); // Use GetX or Navigator.pushReplacement
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100], // Light Green Background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(20.0),
              child: Lottie.asset(
                'assets/lottie/chat.json', // Replace with your Lottie animation file
                width: Get.width * 0.5,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "GupShup",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary, // Primary color from theme
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Let's Chat",
              style: TextStyle(fontSize: 16, color: Colors.green[600]),
            ),
          ],
        ),
      ),
    );
  }
}
