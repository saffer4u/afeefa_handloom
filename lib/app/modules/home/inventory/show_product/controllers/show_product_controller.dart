import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ShowProductController extends GetxController {
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
}
