import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void createNewUser(Map<String, String?> userInfo) async {
    // print('create new user called');
    // print(userInfo.toString());
    if (!await userExistCheck(userInfo['uid']!)) {
      // This function only called if user does not exist in Database.
      await firestore
          .collection('users')
          .doc(userInfo['uid'])
          .set({'phoneNumber': userInfo['phoneNumber'],'isProfileCreated':false});
    } else {
      print('User data already exists');
    }
  }

  Future<bool> userExistCheck(String uid) async {
    try {
      var collectionRef = firestore.collection('users');
      var doc = await collectionRef.doc(uid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
