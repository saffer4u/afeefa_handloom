import 'package:afeefa_handloom/app/constents/snakbars.dart';
import 'package:afeefa_handloom/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _authInstence = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  var isLoadig = false.obs;
  String _verificationCode = '';

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_authInstence.currentUser);
    firebaseUser.bindStream(_authInstence.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user != null) {
      // User LoggedIn.
      Get.offAllNamed(Routes.HOME);
    } else {
      // User is not logged in.
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // void signUp(String email, String password) async {
  //   isLoadig(true);
  //   await _authInstence.createUserWithEmailAndPassword(
  //       email: email, password: password);
  //   isLoadig(false);
  // }

  void phoneLogIn(String phoneNo) async {
    await _authInstence.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _authInstence.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Snakebars().errorBar(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationCode = verificationId;
        Get.toNamed(Routes.OTP, arguments: phoneNo);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationCode = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<bool> submitOtp(String pin, BuildContext ctx) async {
    try {
      await _authInstence.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationCode,
          smsCode: pin,
        ),
      );
      return false;
    } on FirebaseAuthException catch (e) {
      FocusScope.of(ctx).unfocus();
      Snakebars().errorBar(e.message.toString());
      // Get.snackbar("Error", e.message.toString());
      return true;
    }
  }

  void logOut() async {
    await _authInstence.signOut();
  }
}
