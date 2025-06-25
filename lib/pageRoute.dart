import 'package:chatapp/pages/ChatPage.dart';
import 'package:chatapp/pages/HomePage.dart';
import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register_Page.dart';
import 'package:chatapp/pages/settings.dart';
import 'package:get/get.dart';

class PageRoutes{
  String login='/login';
  String register='/register';
  String settings='/settings';
  String home='/home';
  String chatPage='/chatPage';
  List<GetPage> getPages(){
    return [
      GetPage(name: login, page: () => LoginPage()),
      GetPage(name: register, page: () => RegisterPage()),
      GetPage(name: settings, page: () => Settings()),
      GetPage(name: home, page: () => HomePage()) ,
      GetPage(name: chatPage, page:()=>ChatPage(
        receiverEmailId: Get.arguments['receiverEmail'] ?? '', receiverId: Get.arguments['receiverId'] // Assuming you pass emailId as an argument
      ))// Assuming you have a SettingsPage
      // Add more pages here
    ];
  }
}