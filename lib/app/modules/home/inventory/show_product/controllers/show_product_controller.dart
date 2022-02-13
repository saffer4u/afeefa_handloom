import 'dart:io';

import 'package:afeefa_handloom/app/controllers/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import '../../../../../constents/colors.dart';

class ShowProductController extends GetxController {
  final CircleColorPickerController? colorController = CircleColorPickerController(initialColor: slate);
  TextEditingController textController = TextEditingController();

  var pickedColor = Rx<Color>(Colors.blue);
  var pickedColorList = Rx<List<String>>([]);

  Future shareProduct(List<String> imageUrlsList, String text) async {
    List<String> imagePathsList = [];
    for (var i = 0; i < imageUrlsList.length; i++) {
      final urlImage = imageUrlsList[i];
      final url = Uri.parse(urlImage);
      final response = await http.get(url);
      final bytes = response.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image$i.jpg';
      File(path).writeAsBytesSync(bytes);
      imagePathsList.add(path);
    }

    await Share.shareFiles(
      imagePathsList,
      text: text,
    );
  }

  Future<void> deleteImages(List<dynamic> imagesList) async {
    for (var i = 0; i < imagesList.length; i++) {
      await Get.find<StorageController>().deleteImageFromStorage(imagesList[i]);
    }
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
