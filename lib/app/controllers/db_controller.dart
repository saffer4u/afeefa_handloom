import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../data/config_model.dart';
import '../modules/home/add_product/controllers/add_product_controller.dart';
import '../modules/home/add_product/model/product.dart';
import '../modules/home/cart/models/cart_product_model.dart';
import '../modules/home/create_edit_profile/model/user_profile_model.dart';
import '../widgets/snakbars.dart';
import 'auth_controller.dart';

class DbController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isAdmin = false.obs;
  late Rx<UserProfile> userProfile;
  var userExist = false.obs;

  // var configData = Rx<ConfigModel>(ConfigModel(userType: ['Clint']));

  var configData = ConfigModel(userType: ['Clint']).obs;

  //* Return true if user exist.
  Future<bool> userExistCheck() async {
    log('Check user exist called');
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
    log('Check product exist called');
    try {
      var collectionRef = firestore.collection('products');
      var doc = await collectionRef.doc(docName).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  //? Cart methods -------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<bool> productExistInCartCheck({required String productId}) async {
    log("Check product exist in cart called");
    try {
      var collectionRef = firestore.collection('users/${Get.find<AuthController>().getUid}/cart');
      var doc = await collectionRef.doc(productId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProductToCart(CartProductModel cartProduct) async {
    try {
      await firestore.collection("users/${Get.find<AuthController>().getUid}/cart").doc(cartProduct.productId).set(cartProduct.toJson());
      customBar(
        title: "Successful",
        message: "Product added to cart",
        duration: 3,
      );
    } catch (e) {
      log("Error while adding product to cart : $e");
      customBar(
        title: "Error",
        message: "Something went wrong please try again",
        duration: 2,
      );
    }
  }

  Future<void> getConfigData() async {
    var snapshot = await firestore.collection('config').doc('configData').get();
    List<dynamic> userTypeList = snapshot.data()!['userType'];

    configData.update(
      (val) {
        val!.userType = userTypeList.cast<String>();
      },
    );
    log("Config File arrived");
    // log(configData.value.userType);
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
      log('User data fatched');
    } catch (e) {
      log("User Data fatch error : $e");
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

  Stream<List<CartProductModel>> getCartItems() {
    var products = firestore.collection("users/${Get.find<AuthController>().getUid}/cart").orderBy('item_add_time', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
            // log(doc.data().toString());
            return CartProductModel.fromJson(
              doc.data(),
            );
          }).toList(),
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

  Future<void> updateProductValueInDb({
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
    // log(assignedProducts);
    return assignedProducts;
  }
}
