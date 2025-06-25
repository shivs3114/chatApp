import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
 final FirebaseAuth _authService = FirebaseAuth.instance;
 final FirebaseFirestore _firestore=FirebaseFirestore.instance;

 User? getCurrentUser() {
    return _authService.currentUser;
  }

  @override
  void onInit() {
    super.onInit();
    // You can add any initialization logic here if needed
  }

  Future<void> signInWithGoogle() async {
    try {
      UserCredential userCredential = await _authService.signInWithPopup(GoogleAuthProvider());
      Get.snackbar('Success', 'Signed in as ${userCredential.user?.email}');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

 Future<void> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password:password,
      );
      Get.snackbar('Success', 'Signed in as ${userCredential.user?.email}');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
      try {
        UserCredential userCredential = await _authService.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //save user info it doesnt exists already
        _firestore.collection('USERS').doc(userCredential.user!.uid).set(
          {"uid":userCredential.user!.uid,
          'email':userCredential.user!.email
          },
        );
        Get.snackbar('Success', 'Registered as ${userCredential.user?.email}');
      } on FirebaseAuthException catch (e) {
        
      throw Exception(e);
      }
    }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}