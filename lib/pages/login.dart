import 'package:chatapp/components/Button.dart';
import 'package:chatapp/components/MyTextfield.dart';
import 'package:chatapp/controller/authController.dart';
import 'package:chatapp/pageRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  // This widget is the login page of your application. It is stateless, meaning
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  final void Function()? onTap;
  AuthController authService = Get.put(AuthController());
   LoginPage({super.key, this.onTap});
  void login(BuildContext context) async {
    try {
    
      await authService.signInWithEmail(emailController.text.trim(), pwController.text.trim());
    } catch (e) {
      showDialog(context: context, builder:(context)
      {return AlertDialog(
        title: Text('Error'),
        content: Text(e.toString()),
        
      );});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          Icon(Icons.message,size: 60,),
          Text('Welcome  back,you have been missed! '
          ,style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          )),
              MyTextField(hintText: 'Enter email',controller: emailController,obscure: false,),
          MyTextField(hintText: 'Enter password',controller: pwController,obscure: true,),
          SizedBox(height: 20,),

          CustomButtons(title: 'Login',
          onTap:()=>login(context),),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
                TextButton(
                onPressed: onTap,
                child: Text(
                  'Register',
                  style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  ),
                ),
                ),
              
            ],
          ),
            Center(
              child: GestureDetector(
              onTap: () => Get.toNamed(PageRoutes().home),
              child: Container(
                decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 8),
                  Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  ),
                ],
                ),
              ),
              ),
            )



        ],
      ),
    );
  }
  //12:04
}