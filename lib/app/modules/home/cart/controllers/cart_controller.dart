import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../components/dialogs/confirmation_dialog.dart';
import '../../../../components/dialogs/edit_cart_dialog.dart';
import '../../../../controllers/db_controller.dart';
import '../../../../widgets/snakbars.dart';
import '../models/cart_product_model.dart';

class CartController extends GetxController {
  //* Get total of all product price x Qty

  double getTotal({required List<CartProductModel> cartProducts}) {
    double sum = 0;
    for (var element in cartProducts) {
      sum += double.parse(element.price!) * element.quantity!.toDouble();
    }
    return sum;
  }

  double getGstValue({required List<CartProductModel> cartProducts}) {
    double sum = 0;
    for (var element in cartProducts) {
      sum += double.parse(element.price!) * element.quantity!.toDouble();
    }
    return sum * 0.05;
  }

  void onPressNavToProduct({required String productId}) {
    
  }

  void onPressDelete({required String productId}) {
    confirmationDialog(
      title: "Remove",
      bodyText: "Are you sure?",
      onPressOk: () async {
        Get.back();
        await Get.find<DbController>().deleteProductFromCart(productId: productId);
      },
    );
  }

  void onPressEdit({
    required String productId,
    required String qty,
  }) {
    TextEditingController editCartController = TextEditingController(text: qty);
    editCartDialog(
      controller: editCartController,
      onPressOk: () async {
        Get.back();
        int existingStock = await Get.find<DbController>().getStockOfProduct(productId: productId);
        if (int.parse(editCartController.text) < 1 || existingStock < int.parse(qty)) {
          customBar(
            title: "Invalid Range",
            message: "Not in stock please select between range [ 1 : $existingStock ]",
            duration: 3,
          );
        } else {
          try {
            await Get.find<DbController>().editCartItemQuantity(productId: productId, qty: int.parse(editCartController.text.trim()));
            customBar(title: "Updated", duration: 2);
          } catch (e) {
            customBar(title: "Error", message: e.toString(), duration: 2);
          }
        }
      },
    );
  }
}
