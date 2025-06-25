import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtons extends StatelessWidget {
  //final VoidCallback onPressed;
  final void Function() onTap;
  final String title;
  final Color? color;
  final double? width;
  final double? height;
  

  const CustomButtons({super.key,required this.title, this.color, this.width, required this.onTap,  this.height});

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onTap,
      child: Container(width: width ?? Get.width * 0.5,
      height: height??Get.height * 0.07,
        decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
        color: Theme.of(context).colorScheme.primary,),),
        child: Center(
          child: Text(title,style: GoogleFonts.abel(
           color: Theme.of(context).colorScheme.surface,
           fontSize: 20,
                  )),
        )),
    );
  }
}