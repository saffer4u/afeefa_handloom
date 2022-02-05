import 'dart:io';

import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constents/colors.dart';

enum ImageType {
  user,
  logo,
}

class CreateEditProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var uploadImageFile = Rx<File?>(null);
  var uploadLogoFile = Rx<File?>(null);

  var userTypeDropDownItems =
      Get.find<DbController>().configData.value.userType;
  var userTypeDropDownValue =
      Get.find<DbController>().configData.value.userType[0].obs;

  Future<void> picImageSquare(ImageType imageType) async {
    print(imageType);
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;

    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
          cropGridColor: slate,
          // hideBottomControls: true,

          cropFrameColor: royal,
          toolbarTitle: 'Crop Image',
          backgroundColor: concrete,
          toolbarColor: slate,
          toolbarWidgetColor: royal,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
    );

    if (croppedFile != null) {
      if (imageType == ImageType.user) {
        uploadImageFile.update((val) {
          uploadImageFile.value = croppedFile;
        });
      } else if (imageType == ImageType.logo) {
        uploadLogoFile.update((val) {
          uploadLogoFile.value = croppedFile;
        });
      }

      // print("Cropped file added");
      // print(await image.length());
    }
  }

  void createClintProfileModel() {
    
  }
}
