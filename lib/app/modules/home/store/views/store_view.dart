import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/db_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_progress_indicator.dart';
import '../../../../widgets/subtitle_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../../add_product/model/product.dart';
import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (_) {
      return StreamBuilder<List<Product>>(
        stream: Get.find<DbController>().readProduct(),
        builder: ((_, snapshot) {
          if (snapshot.hasError) {
            return Center(child: TitleWidget(title: "Something went wrong..."));
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: TitleWidget(title: "No Products..."),
              );
            } else {
              // Get.find<InventoryController>().totalStock.value = 0;

              final products = snapshot.data!.where((element) {
                // List<String> assignedProducts = ['AH1235', 'AH1236'];
                for (var item in controller.assignedProducts) {
                  if (element.id == item) {
                    for (var item in controller.allAssignedproducts) {
                      if (item['id'] == element.id) {
                        element.rate = item['assignPrice'].toString();
                        element.productAddTime = (item['assignTime'] as Timestamp).toDate();
                      }
                    }
                    return true;
                  }
                }
                return false;
              }).toList();
              products.sort((a, b) => b.productAddTime.compareTo(a.productAddTime));
              if (products.isEmpty) {
                return Center(
                  child: TitleWidget(title: "No Products Assigned..."),
                );
              }

              return RefreshIndicator(
                onRefresh: () {
                  return controller.fatchAssignedProducts();
                },
                child: GridView.builder(
                    // physics: BouncingScrollPhysics(),
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1 / 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (BuildContext ctx, index) {
                      // Get.find<InventoryController>().totalStock.value += products[index].stock;

                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: offWhite,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                        products[index].images[0],
                                        height: 180,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Container(
                                            height: 200,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: royal,
                                                color: redOrenge,
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              child: InkWell(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SubTitleWidget(title: products[index].title),
                                      ),
                                      GradientText(
                                        " ID : ${products[index].id}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        colors: [
                                          royal,
                                          redOrenge,
                                        ],
                                      ),
                                      GradientText(
                                        products[index].stock != 0 ? " Stock : ${products[index].stock} PCS." : "Stock : Empty",
                                        style: TextStyle(),
                                        colors: [
                                          royal,
                                          redOrenge,
                                        ],
                                      ),
                                      GradientText(
                                        "Price : ${products[index].rate}₹",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        colors: [redOrenge, Colors.green],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                splashColor: redOrenge.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                // onLongPress: () {
                                //   Get.toNamed(
                                //     Routes.SHOW_PRODUCT,
                                //     arguments: products[index],
                                //   );
                                // },
                                onTap: () {
                                  Get.toNamed(Routes.CLINT_SHOW_PRODUCT, arguments: products[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              );
            }
          } else {
            return Center(
              child: CustomProgressIndicator(),
            );
          }
        }),
      );
    });
  }
}
