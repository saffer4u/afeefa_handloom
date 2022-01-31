import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
              ),
              TextFormField(
                controller: passwordController,
              ),
              MaterialButton(
                onPressed: () {
                  Get.find<AuthController>().signUp(emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Text("Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
