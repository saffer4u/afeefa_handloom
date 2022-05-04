import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/login/otp/controllers/otp_controller.dart';
import '../routes/app_pages.dart';
import '../widgets/snakbars.dart';
import 'db_controller.dart';

class AuthController extends GetxController {
  final FirebaseAuth _authInstence = FirebaseAuth.instance;
  final dbController = Get.find<DbController>();

  String get getUid => _authInstence.currentUser!.uid;
  String get getPhoneNumber => _authInstence.currentUser!.phoneNumber!;

  // late Map<String, String?> currentUser;

  late Rx<User?> firebaseUser;
  var isLoadig = false.obs;
  String _verificationCode = '';

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_authInstence.currentUser);
    firebaseUser.bindStream(_authInstence.userChanges());

    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  void _setInitialScreen(User? user) async {
    // print('User Streen : $user');
    if (user != null) {
      // Check whether user is admin.

      // User LoggedIn.
      // currentUser = getCurrentUserInfo();
      // await dbController.createNewUser(currentUser);
      await dbController.getConfigData();
      if (await dbController.userExistCheck()) {
        await dbController.fatchUserData();
      }
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

  Future<void> phoneLogIn(String phoneNo) async {
    await _authInstence.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _authInstence.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        customBar(message: e.message.toString(), title: 'Error');
        isLoadig.value = false;
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationCode = verificationId;
        isLoadig.value = false;
        Get.toNamed(Routes.OTP, arguments: phoneNo);
        Get.find<OtpController>().startCountDown();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //! Not sure if it is working.
        isLoadig.value = false;
        _verificationCode = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<bool> submitOtp(String pin, BuildContext ctx) async {
    try {
      FocusScope.of(ctx).unfocus();
      await _authInstence.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationCode,
          smsCode: pin,
        ),
      );
      isLoadig.value = false;
      return false;
    } on FirebaseAuthException catch (e) {
      FocusScope.of(ctx).unfocus();
      isLoadig.value = false;
      print(e);
      customBar(
        message: 'Invalid OTP please recheck',
        title: 'Error',
        duration: 2,
      );
      // Get.snackbar("Error", e.message.toString());
      return true;
    }
  }

  void logOut() => _authInstence.signOut();

  // Map<String, String?> getCurrentUserInfo() {
  //   User? user = _authInstence.currentUser;
  //   Map<String, String?> currentUserInfo = {
  //     'uid': user?.uid,
  //     'phoneNumber': user?.phoneNumber,
  //   };
  //   return currentUserInfo;
  // }
}
