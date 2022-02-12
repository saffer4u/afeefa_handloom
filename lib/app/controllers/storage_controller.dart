import 'dart:io';

import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart';

class StorageController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  

  // Future<String?> upladUserImage(File file) async {
  //   Reference reference = storage.ref().child("userImages");
  //   UploadTask uploadTask = reference.putFile(file);
  //   uploadTask.then((res) {
  //      var url = res.ref.getDownloadURL();
  //   });
  // }

  Future<String?> upladImageToFirebaseStorage({
    required String path,
    required File file,
    required String fileName,
  }) async {
    // File file = File(filePath);
    
    try {
      final uploadRes = await storage.ref('$path/$fileName').putFile(file);
      return await storage.ref(uploadRes.metadata!.fullPath).getDownloadURL();
    } on FirebaseException {
      
      return null;
    }
  }
}
