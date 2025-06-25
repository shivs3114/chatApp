import 'package:chatapp/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chatcontroller extends GetxController{
  //instance of firestore
  final FirebaseAuth _auth=FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   //get user stream
   Stream<List<Map<String,dynamic>>> getUsersStream()
   { return _firestore.collection("USERS").snapshots().map((snapshot)
   {return snapshot.docs.map((doc){
    //go through each indivivdual user document
    final user=doc.data();
    return user;
    //returning user data as a map
   }).toList();
   });}

   Stream<List<Map<String,dynamic>>> getUsersStreamExcludingBlocked()
   { final currentUser=_auth.currentUser;
     return _firestore
     .collection("USERS")
     .doc(currentUser!.uid)
     .collection('BlockedUsers')
     .snapshots()
     .asyncMap((snapshot)async{
      final blockedUserIds=snapshot.docs.map((doc)=>doc.id).toList();
      final usersSnapshot=await _firestore.collection('USERS').get();
      return usersSnapshot.docs
      .where((doc)=>doc.data()['email'] !=currentUser.email &&
      !blockedUserIds.contains(doc.id)).map((doc)=>doc.data()).toList();
      });
    
   }

  //get chat stream
  Future<void>sendMessage(String receiverId,message)async{
    final String currentUserID=_auth.currentUser!.uid;
    final String currentUserEmail=_auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage=Message(senderId:currentUserID, receiverId: receiverId, message: message, timestamp: timestamp, senderEmail: currentUserEmail);
    List<String> chatIds=[currentUserID,receiverId];
    chatIds.sort(); // Ensure consistent order for chat ID
    String chatRoomId=chatIds.join('_');
    await _firestore.collection("Chat_rooms")
    .doc(chatRoomId)
    .collection("messages")
    .add(newMessage.toMap());
    // Optionally, you can also update the chat room metadata if needed
  }

  Stream<QuerySnapshot> getMessagesStream(String receiverId,userId) {

    List<String> chatIds = [userId, receiverId];
    chatIds.sort(); // Ensure consistent order for chat ID
    String chatRoomId = chatIds.join('_');
    
    return _firestore.collection("Chat_rooms")
      .doc(chatRoomId)
      .collection("messages")
      .orderBy('timestamp', descending: false)
      .snapshots();
  }

  //Report User
   
Future<void> reportUser(String messageId,String userId) async {
  final currentUser=_auth.currentUser;
  final report={
    'reportedBy':currentUser!.uid,
    'messageId':messageId,
    'messageOwnerId':userId,
    'timestamp':FieldValue.serverTimestamp()
  };
  await _firestore.collection('Reports').add(report);
}
  //Block User
Future<void> blockUser(String userId) async
{final currentUser=_auth.currentUser;
await _firestore
.collection('USERS')
.doc(currentUser!.uid)
.collection('BlocedUsers')
.doc(userId)
.set({});
}
  //Unblock User
Future<void>unblockUser(String blockedUserId )async{
  final currentUser=_auth.currentUser;
  await _firestore
.collection('USERS')
.doc(currentUser!.uid)
.collection('BlockedUsers')
.doc(blockedUserId)
.delete();

}

  //Get blocked user stream
  Stream<List<Map<String,dynamic>>> getBlockedUsersStream(String userId)
  { return _firestore.collection('USERS').doc(userId).collection('BlockedUsers').snapshots()
  .asyncMap((snapshot) async {
    //getting list of blocked user id
    final blockedUserIds=snapshot.docs.map((doc)=>doc.id).toList();
    final userDocs=await Future.wait(
      blockedUserIds.map((id)=>_firestore.collection('USERS').doc(id).get())
    );
    return userDocs.map((doc)=>doc.data() as Map<String,dynamic>).toList();
  });

  }


}