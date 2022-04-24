import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/clint_dashbord_controller.dart';

class ClintDashbordView extends GetView<ClintDashbordController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ClintDashbordView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
