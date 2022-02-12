import 'dart:io';

import 'package:afeefa_handloom/app/controllers/storage_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constents/colors.dart';
import '../model/product.dart';

class AddProductController extends GetxController {
  // Product product = Product(productAddTime: DateTime.now());

  final formKey = GlobalKey<FormState>();

  // Conterollers
  final CircleColorPickerController? colorController = CircleColorPickerController(initialColor: slate);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController fabricController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // ImagePicker
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? pickedImagesFileList;

  // Observable variables
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

  Future<List<String>> uploadProductImages(List<File?> files) async {
    List<String> imagesLinkList = [];
    for (var file in files) {
      var fileLink = await Get.find<StorageController>().upladImageToFirebaseStorage(
        path: 'productimages/${idController.text}',
        file: file!,
        fileName: file.path.split('/').last,
      );
      if (fileLink != null) {
        imagesLinkList.add(fileLink);
      }
    }
    print(imagesLinkList);
    return imagesLinkList;
  }

  Future<Product> productToObject() async {
    Product product = Product(
        productAddTime: DateTime.now(),
        colors: pickedColorList.value,
        description: descriptionController.text.trim(),
        fabric: fabricController.text.trim(),
        id: "AH${idController.text}",
        rate: rateController.text.trim(),
        title: titleController.text.trim(),
        sizes: sizeController.text.trim(),
        weight: weightController.text.trim(),
        images: await uploadProductImages(croppedImageFileList.value));

    return product;
  }

 
}
