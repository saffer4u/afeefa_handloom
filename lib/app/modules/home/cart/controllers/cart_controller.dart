import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../components/dialogs/confirmation_dialog.dart';
import '../../../../components/dialogs/edit_cart_dialog.dart';
import '../../../../controllers/db_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/snakbars.dart';
import '../../add_product/model/product.dart';
import '../../orders/models/orders_model.dart';
import '../models/cart_product_model.dart';

class CartController extends GetxController with StateMixin<dynamic> {
  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  var isLoading = false.obs;
  int selectedProductIndex = 0;
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

  void onPressNavToProduct({
    required String productId,
    required String productRate,
    required int productIndex,
  }) async {
    selectedProductIndex = productIndex;
    isLoading.value = true;
    // log("Get to product clicked");
    try {
      Product product = await Get.find<DbController>().getSingleProductById(productId: productId);
      product.rate = productRate;
      isLoading.value = false;
      Get.toNamed(Routes.CLINT_SHOW_PRODUCT, arguments: product);
    } catch (e) {
      isLoading.value = false;
      customBar(title: "Something went wrong", duration: 3, message: e.toString());
    }
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
    required int qty,
  }) {
    TextEditingController editCartController = TextEditingController(text: qty.toString());
    editCartDialog(
      controller: editCartController,
      onPressOk: () async {
        Get.back();
        int existingStock = await Get.find<DbController>().getStockOfProduct(productId: productId);

        if (int.parse(editCartController.text) < 1 || existingStock < int.parse(editCartController.text)) {
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

  Future<void> onPressPlaceOrder() async {
    //* Start loading
    change(null, status: RxStatus.loading());
    bool isStockAvailable = true;

    //* Crate an object of order
    List<CartProductModel> cartProducts = await Get.find<DbController>().getCartItems().first;
    OrdersModel orders = OrdersModel(
      cartProductModel: cartProducts,
      gst: getGstValue(cartProducts: cartProducts),
      total: getTotal(cartProducts: cartProducts),
      netAmount: getGstValue(cartProducts: cartProducts) + getTotal(cartProducts: cartProducts),
      orderId: await Get.find<DbController>().getRandomOrderId(),
    );

    //* check if stock available

    for (var item in orders.cartProductModel!) {
      int stock = await Get.find<DbController>().getStockOfProduct(productId: item.productId!);
      if (stock < item.quantity!) {
        customBar(
          title: "Stock not available",
          message: "Please select ${item.title} quantity between [1 : $stock]",
          duration: 3,
        );
        isStockAvailable = false;
        break;
      }
    }

    // log(ordersModelToJson(orders).toString());
    // await Get.find<DbController>().placeOrder(orders);
    // log(await Get.find<DbController>().getRandomOrderId());
    // print();

    change(null, status: RxStatus.success());
  }
}
