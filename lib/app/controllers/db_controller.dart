import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isAdmin = false.obs;
  var userData = Rx<Map<String, dynamic>?>({'': ''});

  // add user to db if not already added.
  void createNewUser(Map<String, String?> userInfo) async {
    // print('create new user called');
    // print(userInfo.toString());
    if (!await userExistCheck(userInfo['uid']!)) {
      // This function only called if user does not exist in Database.
      await firestore.collection('users').doc(userInfo['uid']).set({
        'phoneNumber': userInfo['phoneNumber'],
        'isProfileCompleted': false,
        'isAdmin': false,
      });
    } else {
      print('User data already exists');
    }
    await getUserData(userInfo['uid']!);
    isAdmin.value = userData.value!['isAdmin'];
  }

  // Return true if user exist.
  Future<bool> userExistCheck(String uid) async {
    try {
      var collectionRef = firestore.collection('users');
      var doc = await collectionRef.doc(uid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  // Admin check and assgin in obx var.
  // void checkIsAdmin(String uid) async {
  //   if (await userExistCheck(uid)) {
  //     var collectionRef = firestore.collection('users');
  //     var doc = await collectionRef.doc(uid).get();
  //     isAdmin.value = doc.data()!['isAdmin'];
  //   }
  // }

  // Return user data from db.
  // Future<Map<String, dynamic>?>
  Future<void> getUserData(String uid) async {
    var collectionRef = firestore.collection('users');
    var doc = await collectionRef.doc(uid).get();
    userData.value = doc.data();
    print('Data reset');
  }
}
