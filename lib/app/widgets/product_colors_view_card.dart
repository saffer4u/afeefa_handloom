import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../modules/home/add_product/controllers/add_product_controller.dart';

class ProductColorsViewCard extends StatelessWidget {
  const ProductColorsViewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Get.find<AddProductController>()
              .pickedColorList
              .value
              .map((data) {
            return Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(width: 2, color: Colors.white),
                    color: HexColor(data),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
