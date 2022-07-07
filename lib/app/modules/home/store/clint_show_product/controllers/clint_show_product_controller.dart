import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../../constents/colors.dart';
import '../../../../../controllers/db_controller.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/snakbars.dart';
import '../../../add_product/model/product.dart';
import '../../../cart/models/cart_product_model.dart';

class ClintShowProductController extends GetxController {
  late Product product;
  var isProductInCart = false.obs;

  TextEditingController quantityController = TextEditingController();

  @override
  void onInit() async {
    product = Get.arguments as Product;
    log("Product view ${product.title} ${product.id}");
    isProductInCart.value = await Get.find<DbController>().productExistInCartCheck(productId: product.id);
    super.onInit();
  }

  //? Other methods --------------->>>>>>>>>>>>>>>>>>>>>

  //* Add items to cart handler
  Future<void> addToCart({required ctx}) async {
    TextEditingController rateController = TextEditingController();
    rateController.text = Get.arguments.rate;

    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        actionsPadding: EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: concrete,
        title: GradientText(
          "Quantity",
          colors: [redOrenge, royal, redOrenge],
          style: Theme.of(ctx).textTheme.bodyText1!.copyWith(
                fontSize: 20,
                letterSpacing: 2,
              ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    labelText: "Number of pieces",
                  ),
                ),
              ],
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: Theme.of(ctx).textTheme.bodyText2!.copyWith(
                    color: offWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: addProductToCart,
            child: Text(
              "Ok",
              style: Theme.of(ctx).textTheme.bodyText2!.copyWith(
                    color: offWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  //* Ask about product to admin button handler
  void askButtonPress() {
    log("Ask button pressed");
  }

  //* Add product to cart handler
  void addProductToCart() async {
    log(product.title);

    //* Check if product in stock
    if (int.parse(quantityController.text) > product.stock) {
      customBar(title: "Not in stock", duration: 3, message: "Please select between range [ 1 : ${product.stock} ]");
    } else {
      Get.back();
      //* Check if product exist in cart
      if (isProductInCart.value) {
        customBar(
          title: "Already exist",
          message: "Product already exist in cart",
          duration: 2,
        );
      } else {
        final CartProductModel cartProduct = CartProductModel(
          itemAddTime: DateTime.now().toString(),
          price: product.rate,
          productId: product.id,
          quantity: int.parse(quantityController.text),
          imageUrl: product.images[0],
          title: product.title,
        );

        Get.find<DbController>().addProductToCart(cartProduct).then(
          (value) async {
            isProductInCart.value = true;
            //* Desabled logic of subtracting stock with item added in cart
            // isProductInCart.value = await Get.find<DbController>().productExistInCartCheck(productId: product.id);
            // final leftStock = product.stock - int.parse(quantityController.text.trim());

            // product.stock = leftStock;
            // update();
            // log("Left Stock : ${product.stock}");
            // return Get.find<DbController>().updateProductValueInDb(
            //   docId: product.id,
            //   key: "stock",
            //   value: leftStock.toString(),
            // );
          },
        );
      }
    }
  }
}
