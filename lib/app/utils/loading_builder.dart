//* Image loading builder
import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:flutter/material.dart';

Widget loadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) return child;
  return Container(
    color: concrete,
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: slate,
        color: royal,
        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
      ),
    ),
  );
}
