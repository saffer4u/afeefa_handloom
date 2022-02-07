import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../widgets/custom_progress_indicator.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: Offset(2, 2),
          color: Colors.grey,
          blurRadius: 3.0,
        ),
      ],
      color: slate,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: royal,
      ));
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
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
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 30,
                ),
                GradientText(
                  "OTP Verification",
                  colors: [redOrenge, royal],
                  style: GoogleFonts.baloo(
                    fontSize: 35,
                  ),
                ),

                Obx(() => Get.find<AuthController>().isLoadig.isTrue
                    ? CustomProgressIndicator()
                    : SizedBox()),

                // Obx(
                //   () => Visibility(
                //     child: CustomProgressIndicator(),
                //     visible: Get.find<AuthController>().isLoadig.value,
                //   ),
                // ),

                GradientText(
                  "An OTP has been sent to ${Get.arguments}",
                  colors: [redOrenge, royal],
                  style: GoogleFonts.baloo2(),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      colors: [slate, concrete],
                      begin: Alignment(0, -1),
                      end: Alignment(0, 0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: PinPut(
                      fieldsCount: 6,
                      withCursor: true,
                      textStyle:
                          GoogleFonts.baloo(fontSize: 30.0, color: royal),
                      eachFieldWidth: 50.0,
                      eachFieldHeight: 55.0,
                      // onSubmit: (String pin) => _showSnackBar(pin),
                      onSubmit: (pin) async {
                        Get.find<AuthController>().isLoadig.value = true;
                        if (await Get.find<AuthController>()
                            .submitOtp(pin, context)) {
                          _pinPutController.clear();
                        }
                      },
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration,
                      pinAnimationType: PinAnimationType.fade,
                    ),
                  ),
                ),
                // SizedBox(height: 20,),
                Obx(
                  () => Get.find<OtpController>().seconds.value == 0
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [slate, concrete],
                              begin: Alignment(0, -1),
                              end: Alignment(0, 0),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.watch_later_outlined,
                              color: redOrenge.withOpacity(0.8),
                              size: 30,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            gradient: LinearGradient(
                              colors: [slate, concrete],
                              begin: Alignment(0, -1),
                              end: Alignment(0, 0),
                            ),
                          ),
                          child: GradientText(
                            Get.find<OtpController>().seconds.value.toString(),
                            style: GoogleFonts.baloo(
                              fontSize: 50,
                            ),
                            colors: [redOrenge, royal],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
