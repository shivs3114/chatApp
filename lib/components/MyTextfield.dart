import 'dart:ffi';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
 final String? hintText;
 final TextEditingController? controller;
  bool obscure;
  final FocusNode? focusnode;
 MyTextField({required this.hintText,required this.controller,this.obscure=false,super.key, this.focusnode}) {
   // TODO: implement MyTextField

 }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        focusNode: focusnode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
             color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
               color: const Color.fromARGB(255, 221, 185, 130),
             
              width: 2,
            ),
          ),
          hintText: hintText ?? 'Enter your text here',
        )
      ),
    );
  }
}