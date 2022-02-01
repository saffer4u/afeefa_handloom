import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      ));
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verificaton'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Verify ${Get.arguments}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                withCursor: true,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 50.0,
                eachFieldHeight: 55.0,
                // onSubmit: (String pin) => _showSnackBar(pin),
                onSubmit: (pin) async {
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
            )
          ],
        ),
      ),
    );
  }
}
