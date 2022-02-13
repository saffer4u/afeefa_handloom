import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_product_info_controller.dart';

class UpdateProductInfoView extends GetView<UpdateProductInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateProductInfoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpdateProductInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
