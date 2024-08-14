import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (email == 'Reception') {
      email = 'reception@drashrafyehia.web.app';
    } else if (email == 'Doctor') {
      email = 'doctor@drashrafyehia.web.app';
    }
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      if (user.value!.uid == '6FmqXWkkIcRKLN98pWBqk1jOhH43') {
        Get.toNamed('/reception');
      } else if (user.value!.uid == 'jTZCJBMYBIRW6UCOettsgnYNCeo2') {
        Get.toNamed('/doctor');
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors
      Get.snackbar(
        'Alert',
        e.message.toString(),
        snackPosition: SnackPosition.bottom,
        duration: const Duration(seconds: 4),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      user.value = null;
      // Navigate to login screen or home screen based on your app logic
      Get.offAllNamed('/'); // Replace '/login' with your desired route
    } catch (e) {
      // Handle sign-out errors
    }
  }
}