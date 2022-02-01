import 'dart:ui';

import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/routes/app_pages.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[redOrenge, royal],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [offWhite, concrete],
            begin: Alignment(0, -1),
            end: Alignment(0, 0),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 1.0,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 180,
                      width: 180,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    // width: 250.0,
                    child: DefaultTextStyle(
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient,
                      ),
                      child: AnimatedTextKit(
                        totalRepeatCount: 100,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'WELCOME',
                            speed: Duration(milliseconds: 200),
                          ),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),

/*
                  GradientText(
                    "WELCOME",
                    colors: [redOrenge, royal, slate],
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  */
                  SizedBox(
                    height: 10,
                  ),
                  GradientText(
                    "Please verify your phone number to get started.",
                    colors: [redOrenge, royal],
                    style: GoogleFonts.baloo2(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: TextFormField(
                        cursorColor: slate,
                        cursorWidth: 5,
                        style: GoogleFonts.baloo(
                          color: Colors.grey.shade900,
                          fontSize: 25,
                        ),
                        controller:
                            Get.find<LoginController>().phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          hintText: ' Phone Number',
                          hintStyle: GoogleFonts.baloo(
                            letterSpacing: 4.5,
                            color: Colors.grey.shade500,
                            fontSize: 25,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: redOrenge.withOpacity(0.6),
                              width: 2.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: slate,
                              width: 3.0,
                            ),
                          ),
                          prefix: Text(
                            "+91 ",
                            style: GoogleFonts.baloo(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      // Get.find<AuthController>().phoneLogIn(
                      //   Get.find<LoginController>()
                      //       .phoneNumberController
                      //       .text
                      //       .trim(),
                      // );
                      // Get.toNamed(
                      //   Routes.OTP,
                      //   arguments: Get.find<LoginController>()
                      //       .phoneNumberController
                      //       .text,
                      // );
                      Get.find<AuthController>().phoneLogIn(
                          '+91${Get.find<LoginController>().phoneNumberController.text}');
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
