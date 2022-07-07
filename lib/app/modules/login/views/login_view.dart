import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constents/colors.dart';
import '../../../controllers/auth_controller.dart';
import '../../../widgets/custom_progress_indicator.dart';
import '../../../widgets/snakbars.dart';
import '../controllers/login_controller.dart';
import '../otp/controllers/otp_controller.dart';

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
          colors: [slate, concrete],
          begin: Alignment(0, -1),
          end: Alignment(0, 0),
        ),
      ),
      child: Obx(
        () => SafeArea(
          child: Get.find<AuthController>().isLoadig.isTrue
              ? Center(child: CustomProgressIndicator())
              : FadeTransition(
                  opacity: controller.fadeInFadeOut,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 20.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 180,
                              width: 180,
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
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
                                // onTap: () {
                                //   print("Tap Event");
                                // },
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          GradientText(
                            "Please verify your phone number to get started.",
                            colors: [redOrenge, royal],
                            style: GoogleFonts.baloo2(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: TextFormField(
                                cursorColor: slate,
                                cursorWidth: 5,
                                cursorRadius: Radius.circular(50),
                                style: GoogleFonts.baloo(
                                  color: Colors.grey.shade900,
                                  fontSize: 25,
                                ),
                                controller: controller.phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 30,
                                  ),
                                  hintText: ' Phone Number',
                                  hintStyle: GoogleFonts.baloo(
                                    letterSpacing: 4,
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
                                    borderRadius: BorderRadius.circular(25),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(10),
                              fillColor: slate,
                              splashColor: redOrenge,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Next",
                                      maxLines: 1,
                                      style: GoogleFonts.baloo(
                                        fontSize: 25,
                                        color: royal,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 30.0,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 22,
                                      color: royal.withOpacity(0.2),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 22,
                                      color: royal.withOpacity(0.5),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 22,
                                      color: royal.withOpacity(0.9),
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                if (controller.phoneNumberController.text.length != 10) {
                                  customBar(duration: 2, title: 'Invalid Phone No.', message: "Phone number should be 10 digits.");
                                } else {
                                  if (Get.find<OtpController>().seconds.value != 0) {
                                    customBar(
                                        duration: 2,
                                        title: 'Please Wait : ${Get.find<OtpController>().seconds.value} Seconds',
                                        message: "Multiple OTP can not be sent within 60 seconds");
                                  } else {
                                    Get.defaultDialog(
                                      title: "",
                                      contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                      content: Column(
                                        children: [
                                          Text(
                                            "+91 ${controller.phoneNumberController.text}",
                                            style: GoogleFonts.baloo(
                                              color: royal,
                                              fontSize: 35,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          GradientText(
                                            "We will be verifying the phone number.\nIs this OK, or would you like to edit the number?",
                                            style: GoogleFonts.baloo2(
                                              color: royal,
                                              fontSize: 15,
                                            ),
                                            colors: [redOrenge, royal],
                                          ),
                                        ],
                                      ),
                                      backgroundColor: slate,
                                      titleStyle: TextStyle(color: Colors.white),
                                      middleTextStyle: TextStyle(color: Colors.white),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                              // Snakebars().errorBar(
                                              //     'This is a test message to test and design the snakebar.');
                                            },
                                            child: Text(
                                              'Edit',
                                              style: GoogleFonts.baloo(
                                                color: royal.withOpacity(0.8),
                                                fontSize: 20,
                                              ),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              Get.back();

                                              Get.find<AuthController>().isLoadig.value = true;

                                              await Get.find<AuthController>()
                                                  .phoneLogIn('+91${Get.find<LoginController>().phoneNumberController.text}');
                                            },
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
                                }
                              },
                            ),
                          ),
                          SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    ));
  }
}
