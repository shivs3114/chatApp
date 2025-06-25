import 'package:chatapp/components/Button.dart';
import 'package:chatapp/components/MyTextfield.dart';
import 'package:chatapp/controller/authController.dart';
import 'package:chatapp/pageRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, this.onTap});
  final AuthController authService = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwCController = TextEditingController();
  final void Function()? onTap;
  // Function to handle registration logic

  void register(BuildContext context) {
    try {
      if (emailController.text.isEmpty || pwController.text.isEmpty || pwCController.text.isEmpty) {
        throw Exception('Please fill in all fields');
      }
      if (pwController.text != pwCController.text) {
        throw Exception('Passwords do not match');
      }
      // Here you would typically call your registration service
      authService.registerWithEmail(emailController.text.trim(), pwController.text.trim());
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Registration successful for ${emailController.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      });
      // For example: await authService.registerWithEmail(emailController.text.trim(), pwController.text.trim());
      print('Registration successful for ${emailController.text}');
      Get.toNamed(PageRoutes().home);
    } catch (e) {
      print('Registration failed: $e');
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
          Text('Let\'s get you started with your account! '
          ,style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          )),
          MyTextField(hintText: 'Enter email', controller:emailController,obscure: false,),
          MyTextField(hintText:'Enter password', controller:pwController,obscure: true,),
          MyTextField(hintText:'Confirm password', controller:pwCController,obscure: true,),
          SizedBox(height: 20,),
          CustomButtons(title: 'Register',onTap:()=>register(context),),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an Acount?'),
              TextButton(
                onPressed: onTap,
                  // Navigate to the login page,
                child: Text('Login now',style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                )),
              ),
            ],
          ),



        ],
      ),
    );
  }
  }

//27:27