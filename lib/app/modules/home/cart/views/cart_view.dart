import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/db_controller.dart';
import '../../../../widgets/custom_progress_indicator.dart';
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
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (_, index) => Divider(height: 0),
                  itemBuilder: (_, index) {
                    return ListTile(
                    
                      contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0,),
                      leading: Container(
                        height: 700,
                        child: Image.network(cartProducts[index].imageUrl!),
                      ),
                    );
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
