import 'package:chatapp/components/MyTextfield.dart';
import 'package:chatapp/components/timeformat.dart';
import 'package:chatapp/controller/authController.dart';
import 'package:chatapp/controller/chatController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  
  final String receiverEmailId;
  final String receiverId;
  // You can pass chatId
  // if needed, or remove it if not used
   ChatPage({super.key, required this.receiverEmailId, required this.receiverId});





  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
   final TextEditingController _messageController = TextEditingController();

   final Chatcontroller _chatController = Chatcontroller();
 final AuthController _authController = AuthController();
 FocusNode myfocusNode=FocusNode();

 void _showOptions(BuildContext context,String messageId, String userId,Chatcontroller _chatController) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Block User'),
              onTap: () {
                // Implement delete message functionality
                // You can call a method from ChatController to delete the message
                _chatController.blockUser(userId);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Report Message'),
              onTap: () {
                // Implement report message functionality
                // You can call a method from ChatController to report the message
                _chatController.reportUser(messageId, userId);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel'),
              onTap: () {
            
                Navigator.pop(context);
              },
            ),
          ],
        ));
      },
    );
  }

 @override
  void initState()
  {super.initState();
  myfocusNode.addListener(()
  {if(myfocusNode.hasFocus)
  {//cause a delay so that the keyboards has time to show up
  //then the amount of remaining space will be calculated,
  //then scroll down
    
    Future.delayed(Duration(milliseconds: 500),()=>scrollDown());}});

    //wait a bit for the list to build ,then scroll to bottom
    Future.delayed(Duration(milliseconds: 500),()=>scrollDown());
  }

@override
void dispose()
{myfocusNode.dispose();
_messageController.dispose();
  super.dispose();}

 final ScrollController _scrollController=ScrollController();
 void scrollDown()
 {_scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:Duration(seconds: 1), curve:Curves.fastOutSlowIn);}


  void sendMessage()async {
    if (_messageController.text.isNotEmpty) {
      await _chatController.sendMessage(widget.receiverId, _messageController.text);
      _messageController.clear();
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmailId),),
      body:Column(
        children: [
          Expanded(child: 
          _buildMessageList()),
          _buildUserInput()
        ],
      )
    );
  }

 Widget _buildMessageList() {
  String senderId = _authController.getCurrentUser()!.uid;
  return StreamBuilder(
    stream: _chatController.getMessagesStream(widget.receiverId, senderId),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      //loading state
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      final messages = snapshot.data!.docs;
      return ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final messageData = messages[index].data() as Map<String, dynamic>;
          final message = messageData['message'] ?? '';
          final senderId = messageData['senderId'] ?? '';
          final messageId=messages[index].id ?? '';

          final dateTime = (messageData['timestamp'] as Timestamp).toDate();
          final isMe = senderId == _authController.getCurrentUser()!.uid;
          
          return Container(
  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
  child: Column(
    crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onLongPress: ()
        {if(!isMe)
        { 
          
 
        }

        },
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? const Color.fromARGB(255, 161, 224, 158) : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
          constraints: BoxConstraints(maxWidth: Get.width * 0.75),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 14),
              ),
              
              Text(
                formatTimestamp(dateTime),
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

        },
      );
    },
  );
 }

 Widget _buildUserInput()
 {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Row(
       children: [
         Expanded(
           child: MyTextField(
              hintText: 'Type a message',
             controller:  _messageController,
              obscure: false,
             focusnode: myfocusNode,
           ),
         ),
         CircleAvatar(
           child: IconButton(
            color: Colors.lightGreen,
             icon: Icon(Icons.send),
             onPressed: sendMessage,
           ),
         ),
       ],
     ),
   );
 }
}


//part 3