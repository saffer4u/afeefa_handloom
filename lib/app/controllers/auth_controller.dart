import 'package:afeefa_handloom/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _authInstence = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

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

  void signUp(String email, String password) async {
    await _authInstence.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  void logOut() async {
    await _authInstence.signOut();
  }
}
