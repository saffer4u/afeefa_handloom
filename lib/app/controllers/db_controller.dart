import 'dart:convert';
import 'dart:ffi';

import 'package:afeefa_handloom/app/modules/home/add_product/controllers/add_product_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../data/config_model.dart';
import '../modules/home/add_product/model/product.dart';
import '../modules/home/create_edit_profile/model/user_profile_model.dart';
import 'auth_controller.dart';

class DbController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isAdmin = false.obs;
  late Rx<UserProfile> userProfile;
  var userExist = false.obs;

  // var configData = Rx<ConfigModel>(ConfigModel(userType: ['Clint']));

  var configData = ConfigModel(userType: ['Clint']).obs;

  // add user to db if not already added.

  // Future<void> createNewUser(Map<String, String?> userInfo) async {
  //   // print('create new user called');
  //   // print(userInfo.toString());
  //   if (!await userExistCheck(userInfo['uid']!)) {
  //     // This function only called if user does not exist in Database.
  //     await firestore.collection('users').doc(userInfo['uid']).set({
  //       'phoneNumber': userInfo['phoneNumber'],
  //       'isProfileCompleted': false,
  //       'isAdmin': false,
  //     });
  //   } else {
  //     print('User data already exists');
  //   }

  //   await getUserData(Get.find<AuthController>().getUid);
  // }

  // Return true if user exist.
  Future<bool> userExistCheck() async {
    print('Check user exist called');
    try {
      var collectionRef = firestore.collection('users');
      var doc = await collectionRef.doc(Get.find<AuthController>().getUid).get();
      userExist.value = doc.exists;
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> productExistCheck(String docName) async {
    print('Check product exist called');
    try {
      var collectionRef = firestore.collection('products');
      var doc = await collectionRef.doc(docName).get();

      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  //Admin check and assgin in obx var.
  // void checkIsAdmin() async {
  //   var collectionRef = firestore.collection('users');
  //   var doc = await collectionRef.doc(Get.find<AuthController>().getUid).get();
  //   isAdmin.value = doc.data()!['isAdmin'];
  // }

  // Return user data from db.
  // Future<Map<String, dynamic>?>
  // Future<void> getUserData(String uid) async {
  //   var collectionRef = firestore.collection('users');

  //   var doc = await collectionRef.doc(uid).get();
  //   userData.update((val) {
  //     val!.addAll(doc.data()!);
  //   });
  //   isAdmin.update((val) {
  //     val = doc.data()!['isAdmin'];
  //   });

  //   print('User Data Fatched');
  // }

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

  Future<void> createClintProfile(UserProfile profile) async {
    var collectionRef = firestore.collection('users');

    await collectionRef.doc(Get.find<AuthController>().getUid).set({"profileCrationTime ": DateTime.now()});

    await collectionRef.doc(Get.find<AuthController>().getUid).update(profile.toMap());

    await fatchUserData();

    // await collectionRef
    //     .doc(Get.find<AuthController>().getUid)
    //     .update({'isProfileCompleted': true});

    // await getUserData(Get.find<AuthController>().getUid);
  }

  Future<void> addProductToDb() async {
    Product product = await Get.find<AddProductController>().productToObject();
    var collectionRef = firestore.collection('products');

    await collectionRef.doc(product.id).set(
          product.toMap(),
        );
  }

  Future<void> fatchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore.collection('users').doc(Get.find<AuthController>().getUid).get();
      Map<String, dynamic> data = snapshot.data()!;

      userProfile = UserProfile.toObject(data).obs;
      isAdmin.value = userProfile.value.isAdmin;
      print('User data fatched');
    } catch (e) {
      print(e);
      print("User Data fatch error");
    }
  }

  Stream<List<Product>> readProduct() {
    var products = firestore.collection("products").orderBy('productAddTime', descending: true).snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Product.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
    return products;
  }

  Stream<QuerySnapshot> getUsersStream() {
    return firestore.collection('users').orderBy('lastMessageTime', descending: true).snapshots();
  }

  Stream<QuerySnapshot> getUserMessageStream({required docId}) {
    return firestore.collection('users').doc(docId).collection('chats').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> deleteProductFromDb(String docId) async {
    await firestore.collection("products").doc(docId).delete();
  }

  Future<void> updateValueInDb({
    required String docId,
    required String key,
    required String value,
  }) async {
    if (key == 'stock') {
      await firestore.collection("products").doc(docId).update({
        key: int.parse(value),
      });
    } else {
      await firestore.collection("products").doc(docId).update({
        key: value,
      });
    }
  }

  Future<void> updateColorsInDb({
    required String docId,
    required String key,
    required List<String> value,
  }) async {
    await firestore.collection("products").doc(docId).update({key: value});
  }

  Future<void> varificationChange({required String docId, required bool value}) async {
    await firestore.collection('users').doc(docId).update(
      {'isVarified': value},
    );
  }

  Future<void> sendMessage({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection('users').doc(docId).collection('chats').add(data);
  }

  Future<void> assignProduct({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection('users').doc(docId).collection('assignedProducts').doc(data['id']).set(data);
  }

  Future<void> deleteAssignedProduct({required String docId, required String productId}) async {
    await firestore.collection("users/$docId/assignedProducts").doc(productId).delete();
  }

  Future<void> changeLastMessageTime({required String docId}) async {
    await firestore.collection('users').doc(docId).update({"lastMessageTime": DateTime.now()});
  }

  Future<List<Map<String, dynamic>>> getAllAssignedProductList(String uid) async {
    var snapshot = await firestore.collection("users/$uid/assignedProducts").get();

    List<Map<String, dynamic>> assignedProducts = [];
    // snapshot.docs.forEach((element) {
    //   assignedProducts = element.data();
    // });

    snapshot.docs.forEach((element) {
      assignedProducts.add(element.data());
    });
    // print(assignedProducts);
    return assignedProducts;
  }
}
