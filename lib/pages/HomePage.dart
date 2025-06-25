import 'package:chatapp/controller/authController.dart';
import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/controller/themeController.dart';
import 'package:chatapp/pageRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  Chatcontroller _chatcontroller=Get.put(Chatcontroller());
  AuthController authController = Get.put(AuthController());
  Themecontroller themeController = Get.put(Themecontroller());
void signOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(" Sign Out"),
        content: Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text("Sign Out"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog first
              authController.signOut();    // Then sign out
              // Or: await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
      
        title: Text('GupShup'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person,size: 40,),),
                  Text(
                    'Welcome, ${authController.getCurrentUser()?.email ?? 'User'}',
                    style: TextStyle(
                      
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(PageRoutes().settings); // Close the drawer
              },
            ),
           
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Sign Out'),
          onTap: ()=>signOut(context),
        )

          ],
        ),
      ),
      body: _buildUserList()
    );}
  
  
  Widget _buildUserList() {
  return StreamBuilder(stream:_chatcontroller.getUsersStream(), builder:(context,snapshot)
  {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No users found'));
    }

    final users = snapshot.data!;
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return buildUserTile(user: user);
      },
    );
  });
  }

Widget buildUserTile({required Map<String, dynamic> user}) {
  if(user['email']!=authController.getCurrentUser()!.email)
  {return UserTile(
    text: user['email'] ?? 'Unknown User',
    onTap: () {
      // Handle user tap, e.g., navigate to chat page
      Get.toNamed(PageRoutes().chatPage, arguments: {
        'receiverId': user['uid'], // Assuming 'uid' is the user ID
        'receiverEmail': user['email'] ?? 'Unknown User', // Pass user name
      });
    },
  );}
  else{
    return Container();
  }
}
}
class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

   UserTile({
    super.key, required this.text, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: ListTile(
        tileColor: const Color.fromARGB(255, 174, 232, 166),
        title: Text(text),
        leading: CircleAvatar(
          child: Icon(Icons.person)), // Display first letter of the name
        
        onTap: onTap
          // Handle user tap
        
      ),
    );
  }
}
