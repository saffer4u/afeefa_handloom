import 'dart:io';

import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({Key? key}) : super(key: key);

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? image;

  Future<void> picImageSquare() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality:50);
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
      
      this.image = croppedFile;
      print("Cropped file added");
      print(await image.length());
    }
  
  }

  // Future<File> imageCompressor(File file) async {
  //   Directory appDocDir = await getTemporaryDirectory();
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     '${await getPath()}',
  //     quality: 88,
  //     rotate: 180,
  //     format: CompressFormat.jpeg,
  //   );
  //   print(file.lengthSync());
  //   print(result!.lengthSync());

  //   return result;
  // }

  // Future getPath() async {
  //   Directory appDocDir = await getTemporaryDirectory();
  //   String appDocPath = appDocDir.path;
  //   print(appDocPath);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await picImageSquare();
            // await getPath();
          },
          child: Icon(Icons.image),
        ),
      ),
    );
  }
}
