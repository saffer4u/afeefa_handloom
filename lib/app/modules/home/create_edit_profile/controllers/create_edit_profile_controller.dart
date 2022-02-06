import 'dart:io';

import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/controllers/storage_controller.dart';
import 'package:afeefa_handloom/app/modules/home/create_edit_profile/model/user_profile_model.dart';
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
  var isUserExist = false.obs;

  @override
  void onInit() async {
    isUserExist.value = await Get.find<DbController>().userExistCheck();
    if (isUserExist.value) {
      userNameController.text =
          Get.find<DbController>().userProfile.value.userName;
      firmNameController.text =
          Get.find<DbController>().userProfile.value.firmName;
      gstNumberController.text =
          Get.find<DbController>().userProfile.value.gstNo;
      bankNameController.text =
          Get.find<DbController>().userProfile.value.bankName;
      accountNumberController.text =
          Get.find<DbController>().userProfile.value.accountNo;
      ifscCodeController.text =
          Get.find<DbController>().userProfile.value.ifscCode;
    }
    super.onInit();
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
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

  Future<void> createClintProfileModel() async {
    UserProfile clintProfile = UserProfile(
      userName: userNameController.value.text,
      firmName: firmNameController.value.text,
      gstNo: gstNumberController.value.text,
      bankName: bankNameController.value.text,
      accountNo: accountNumberController.value.text,
      ifscCode: ifscCodeController.value.text,
      userType: userTypeDropDownValue.value,
      phoneNumber: Get.find<AuthController>().getPhoneNumber,
      profilePicUrl: uploadImageFile.value == null
          ? Get.find<DbController>().userProfile.value.profilePicUrl
          : (await Get.find<StorageController>().upladImageToFirebaseStorage(
              path: 'userImages',
              file: uploadImageFile.value!,
              fileName:
                  '${Get.find<AuthController>().getPhoneNumber}_profile.jpg'))!,
      logoUrl: uploadLogoFile.value == null
          ? Get.find<DbController>().userProfile.value.logoUrl
          : (await Get.find<StorageController>().upladImageToFirebaseStorage(
              path: 'userImages',
              file: uploadLogoFile.value!,
              fileName:
                  '${Get.find<AuthController>().getPhoneNumber}_logo.jpg'))!,
    );

    // Add to Database.

    print(clintProfile.toMap());
    // Get.find<AuthController>().isLoadig.value = false;
    await Get.find<DbController>().createClintProfile(clintProfile);
  }
}
