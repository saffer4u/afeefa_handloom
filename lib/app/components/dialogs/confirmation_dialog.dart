import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constents/colors.dart';

Future<void> confirmationDialog({
  required String title,
  required String bodyText,
  required void Function()? onPressOk,
}) async {
  Get.defaultDialog(
    title: "",
    contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    content: Column(
      children: [
        Text(
          title,
          style: GoogleFonts.baloo(
            color: royal,
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        GradientText(
          bodyText,
          style: GoogleFonts.baloo2(
            color: royal,
            fontSize: 15,
          ),
          colors: [redOrenge, royal],
        ),
      ],
    ),
    backgroundColor: slate,
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
            // Snakebars().errorBar(
            //     'This is a test message to test and design the snakebar.');
          },
          child: Text(
            'NO',
            style: GoogleFonts.baloo(
              color: royal.withOpacity(0.8),
              fontSize: 20,
            ),
          )),
      TextButton(
          onPressed: onPressOk,
          child: Text(
            'YES',
            style: GoogleFonts.baloo(
              color: royal,
              fontSize: 20,
            ),
          )),
    ],
  );
}
