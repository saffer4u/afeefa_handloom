import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constents/colors.dart';
import '../../widgets/custom_text_form_field.dart';

Future<void> editCartDialog({
  required void Function()? onPressOk,
  TextEditingController? controller,
}) async {
  Get.defaultDialog(
    title: "",
    contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    content: Column(
      children: [
        Text(
          "Edit Quantity",
          style: GoogleFonts.baloo(
            color: royal,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // GradientText(
        //   bodyText,
        //   style: GoogleFonts.baloo2(
        //     color: royal,
        //     fontSize: 15,
        //   ),
        //   colors: [redOrenge, royal],
        // ),

        Container(
          width: 150,
          child: CustomTextFormField(
            controller: controller,
            
          ),
        ),
      ],
    ),
    backgroundColor: concrete,
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
            // Snakebars().errorBar(
            //     'This is a test message to test and design the snakebar.');
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.baloo(
              color: royal.withOpacity(0.8),
              fontSize: 20,
            ),
          )),
      TextButton(
          onPressed: onPressOk,
          child: Text(
            'Ok',
            style: GoogleFonts.baloo(
              color: royal,
              fontSize: 20,
            ),
          )),
    ],
  );
}
