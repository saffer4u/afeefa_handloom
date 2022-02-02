import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


  void customBar({
    String? message,
    String? title,
    int? duration,
  }) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        title ?? '',
        style: GoogleFonts.baloo(
          color: redOrenge.withOpacity(0.7),
          fontSize: 20,
        ),
      ),
      messageText: Text(
        message ?? '',
        style: GoogleFonts.baloo2(
          color: concrete.withOpacity(0.5),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: royal.withOpacity(0.7),
      borderRadius: 10,
      margin: EdgeInsets.all(18),
      duration: Duration(seconds: duration ?? 20),
      isDismissible: true,
      // dismissDirection: DismissDirection.horizontal,
    );
  }
