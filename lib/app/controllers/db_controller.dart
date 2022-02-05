import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/data/config_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isAdmin = false.obs;
  var userData = Rx<Map<String, dynamic>?>({});

  // var configData = Rx<ConfigModel>(ConfigModel(userType: ['Clint']));

  var configData = ConfigModel(userType: ['Clint']).obs;

  // add user to db if not already added.
  Future<void> createNewUser(Map<String, String?> userInfo) async {
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

    await getUserData(Get.find<AuthController>().getUid);
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
    userData.update((val) {
      val!.addAll(doc.data()!);
    });
    isAdmin.update((val) {
      val = doc.data()!['isAdmin'];
    });

    print('User Data Fatched');
  }

  Future<void> getConfigData() async {
    var snapshot = await firestore.collection('config').doc('configData').get();
    List<dynamic> userTypeList = snapshot.data()!['userType'];

    configData.update(
      (val) {
        val!.userType = userTypeList.cast<String>();
      },
    );
    print("Config File arrived");
    // print(configData.value.userType);
  }
}
