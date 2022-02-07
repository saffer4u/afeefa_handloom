import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constents/colors.dart';

class AddProductController extends GetxController {
  final CircleColorPickerController? colorController =
      CircleColorPickerController(initialColor: slate);

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? pickedImagesFileList;

  var croppedImageFileList = Rx<List<File?>>([]);
  var pickedColor = Rx<Color>(Colors.blue);
  var pickedColorList = Rx<List<String>>([]);

  void picImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null) {
      List<File?> tempList = [];
      for (var xFile in selectedImages) {
        var cropped = await imageCropper(xFile);
        if (cropped != null) {
          tempList.add(cropped);
          // croppedImageFileList.value.add(cropped);
        }
      }
      croppedImageFileList.update((val) {
        val!.addAll(tempList);
        tempList.clear();
      });
      // pickedImagesFileList = selectedImages;
    }
    // print("Image List Length:" + pickedImagesFileList.toString());
    print('List of Images after Cropping');
    print(croppedImageFileList.value);
  }

  Future<File?> imageCropper(XFile image) async {
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
        backgroundColor: Colors.white,
        toolbarColor: slate,
        toolbarWidgetColor: royal,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,
      ),
    );
    return croppedFile;
  }

  void addColor() {
    String hexString = colorController!.color.value.toRadixString(16);

    hexString = '#' + hexString.substring(2, hexString.length);
    pickedColorList.value.add(hexString);
    print(pickedColorList);
    update();
  }

  void deleteColor(String color) {
    pickedColorList.value.remove(color);
    update();
  }
}
