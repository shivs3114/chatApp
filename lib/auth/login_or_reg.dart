import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register_Page.dart';
import 'package:flutter/material.dart';

class LoginOrReg extends StatefulWidget {
  const LoginOrReg({super.key});

  @override
  State<LoginOrReg> createState() => _LoginOrRegState();
}

class _LoginOrRegState extends State<LoginOrReg> {

  bool showLogin = true;
  void togglePages()
  {setState(() {
    showLogin = !showLogin;
  });}
  @override
  Widget build(BuildContext context) {
    return showLogin?LoginPage(onTap: togglePages,):RegisterPage(onTap: togglePages,);
  }
}