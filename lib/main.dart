import 'package:chatapp/controller/themeController.dart';
import 'package:chatapp/pageRoute.dart';
import 'package:chatapp/pages/landingPage.dart';
import 'package:chatapp/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
Get.put(Themecontroller());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 Themecontroller themeController = Get.find();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(()
      => GetMaterialApp(
        getPages:PageRoutes().getPages(),
        debugShowCheckedModeBanner: false,
        title: 'GUPSHUP',
        darkTheme: darkMode,
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: themeController.theme,
        home:  SplashScreen()
      
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.surface,
     
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Text(
          'Welcome to GUPSHUP!',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
          ),
        ),
      ),
     
    );
  }
}
