import 'package:chatapp/controller/themeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

    Themecontroller themecontroller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 210, 209, 209),
         borderRadius: BorderRadius.circular(10) 
        ),
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dark Mode',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
            CupertinoSwitch(value:themecontroller.isDarkMode.value, onChanged:(value){
            themecontroller.toggleTheme();
            })
          ],
        ),
      )
    );
  }
}