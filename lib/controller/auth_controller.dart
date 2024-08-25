import 'package:dr_ashraf_clinic/view/home_page/home_page.dart';
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
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      if (userCredential.user?.email == 'reception@drashrafyehia.web.app') {
        Get.toNamed('/reception');
      } else if (userCredential.user?.email == 'doctor@drashrafyehia.web.app') {
        Get.toNamed('/doctor');
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors
      Get.snackbar(
        'Alert',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut().then((_) {
        // Clear all dependenciess
        Get.to(() => const HomePage());
      });
      user.value = null;

      // Navigate to login screen or home screen based on your app logic
      // Replace '/login' with your desired route
    } catch (e) {
      // Handle sign-out errors
    }
  }
}
