import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/db_controller.dart';
import '../../../../utils/loading_builder.dart';
import '../../../../utils/round_off.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_progress_indicator.dart';
import '../../../../widgets/subtitle_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_product_model.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TitleWidget(title: "Cart"),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 1,
              child: CircleAvatar(
                backgroundColor: royal,
                child: Icon(
                  Icons.arrow_back,
                  color: slate,
                ),
              ),
            ),
            onPressed: () => Get.back(),
          ),
        ),
        elevation: 1,
        backgroundColor: slate,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [slate, concrete],
            begin: Alignment(0, -1),
            end: Alignment(0, 0),
          ),
        ),
        child: StreamBuilder<List<CartProductModel>>(
          stream: Get.find<DbController>().getCartItems(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: TitleWidget(title: "Something went wrong..."),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: TitleWidget(title: "Cart is empty..."),
                );
              } else {
                List<CartProductModel> cartProducts = snapshot.data!;

                return SafeArea(
                    child: ListView.separated(
                  itemCount: snapshot.data!.length + 2,
                  separatorBuilder: (_, index) => Divider(
                    height: 5,
                    thickness: 1,
                    color: slate,
                    endIndent: 30,
                    indent: 30,
                  ),
                  itemBuilder: (_, index) {
                    if (index == snapshot.data!.length) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: royal),
                            color: offWhite,
                          ),
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "TOTAL : ",
                                      style: Get.theme.textTheme.headline3,
                                    ),
                                    Text(
                                      "GST : ",
                                      style: Get.theme.textTheme.headline3,
                                    ),
                                    Divider(
                                      color: slate,
                                      thickness: 1,
                                      indent: 20,
                                    ),
                                    Text(
                                      "NET AMOUNT : ",
                                      style: Get.theme.textTheme.headline3!.copyWith(fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "   ${roundOff(controller.getTotal(cartProducts: cartProducts), 2)} ₹",
                                      style: Get.theme.textTheme.headline3!.copyWith(color: royal),
                                    ),
                                    Text(
                                      "+ ${roundOff(controller.getGstValue(cartProducts: cartProducts), 2)} ₹",
                                      style: Get.theme.textTheme.headline3!.copyWith(color: royal),
                                    ),
                                    Divider(
                                      color: slate,
                                      thickness: 1,
                                      endIndent: 55,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "   ${roundOff(controller.getGstValue(cartProducts: cartProducts) + controller.getTotal(cartProducts: cartProducts), 2)} ₹",
                                        style: Get.theme.textTheme.headline3!.copyWith(
                                          color: royal,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (index == snapshot.data!.length + 1) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CustomButton(onTap: () {}, label: "Place Order"),
                      );
                    } else {
                      return Card(
                        elevation: 0,
                        color: offWhite,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: royal),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              child: Container(
                                height: 150,
                                width: 150,
                                color: concrete,
                                child: Image.network(
                                  cartProducts[index].imageUrl!,
                                  height: 150,
                                  width: 150,
                                  loadingBuilder: loadingBuilder,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(child: SubTitleWidget(title: cartProducts[index].title!)),
                                    Text(
                                      cartProducts[index].productId!,
                                      style: Get.theme.textTheme.bodyText2!.copyWith(
                                        fontSize: 12,
                                        color: slate,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.yMMMEd().format(DateTime.parse(cartProducts[index].itemAddTime!)),
                                      style: Get.theme.textTheme.bodyText2!.copyWith(
                                        fontSize: 12,
                                        color: slate,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Price : ${cartProducts[index].price} ₹ | QTY : ${cartProducts[index].quantity}",
                                        style: Get.theme.textTheme.bodyText2!.copyWith(color: royal.withOpacity(0.9)),
                                      ),
                                    ),
                                    Spacer(),
                                    FittedBox(
                                      child: Text(
                                        "Subtotal : ${roundOff((cartProducts[index].quantity)! * double.parse(cartProducts[index].price!), 2)} ₹",
                                        style: Get.theme.textTheme.bodyText1!.copyWith(color: royal, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: slate,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              height: 150,
                              width: 50,
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.call_made_rounded),
                                    color: royal,
                                    splashColor: redOrenge,
                                  ),
                                  Divider(height: 0),
                                  IconButton(
                                    onPressed: () => controller.onPressDelete(productId: cartProducts[index].productId!),
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                  Divider(height: 0),
                                  IconButton(
                                    onPressed: () => controller.onPressEdit(
                                      productId: cartProducts[index].productId!,
                                      qty: cartProducts[index].quantity.toString(),
                                    ),
                                    icon: Icon(Icons.edit),
                                    color: concrete,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ));
              }
            } else {
              return CustomProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
