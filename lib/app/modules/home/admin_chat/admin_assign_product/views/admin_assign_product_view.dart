import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/modules/home/admin_chat/controllers/admin_chat_controller.dart';
import 'package:afeefa_handloom/app/widgets/custom_button.dart';
import 'package:afeefa_handloom/app/widgets/snakbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../../controllers/db_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_progress_indicator.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/subtitle_widget.dart';
import '../../../../../widgets/title_widget.dart';
import '../../../add_product/model/product.dart';
import '../controllers/admin_assign_product_controller.dart';

class AdminAssignProductView extends GetView<AdminAssignProductController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GetBuilder<AdminChatController>(
            builder: ((_) {
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
                        for (var item in Get.find<AdminChatController>().assignedProducts) {
                          if (element.id == item) {
                            for (var item in Get.find<AdminChatController>().allAssignedproducts) {
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
                      
                      return GridView.builder(
                          physics: BouncingScrollPhysics(),
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
                                              "Assigned Price : ${products[index].rate}₹",
                                              style: TextStyle(),
                                              colors: [royal, redOrenge, Colors.green],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      splashColor: redOrenge.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      onLongPress: () {
                                        Get.toNamed(
                                          Routes.SHOW_PRODUCT,
                                          arguments: products[index],
                                        );
                                      },
                                      onTap: () {
                                        Get.find<AdminAssignProductController>().rateController.text = products[index].rate;
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                actionsPadding: EdgeInsets.only(bottom: 20),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                backgroundColor: concrete,
                                                // title: GradientText(
                                                //   "Actions",
                                                //   colors: [redOrenge, royal, redOrenge],
                                                //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                //         fontSize: 20,
                                                //         letterSpacing: 2,
                                                //       ),
                                                // ),
                                                // titlePadding: EdgeInsets.zero,
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        products[index].images[0],
                                                        height: 250,
                                                        width: 250,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    GradientText(
                                                      "Actions",
                                                      colors: [redOrenge, royal, redOrenge],
                                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                            fontSize: 20,
                                                            letterSpacing: 2,
                                                          ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextFormField(
                                                            controller: Get.find<AdminAssignProductController>().rateController,
                                                            keyboardType: TextInputType.number,
                                                            prefix: Text(
                                                              '₹',
                                                              style: TextStyle(color: slate),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            Get.back();

                                                            await Get.find<AdminAssignProductController>().assignProduct(products[index].id);
                                                            await Get.find<AdminChatController>().fatchAssignedProducts();
                                                            customBar(duration: 1, title: "Price Updated Successfully");
                                                          },
                                                          child: Text(
                                                            "Update Price",
                                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                  color: offWhite,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.back();
                                                              showDialog(
                                                                context: context,
                                                                builder: (_) => AlertDialog(
                                                                  actionsPadding: EdgeInsets.only(bottom: 20),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  backgroundColor: concrete,
                                                                  title: GradientText(
                                                                    "Unassign",
                                                                    colors: [redOrenge, royal, redOrenge],
                                                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                          fontSize: 20,
                                                                          letterSpacing: 2,
                                                                        ),
                                                                  ),
                                                                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      onPressed: () => Get.back(),
                                                                      child: Text(
                                                                        "Cancel",
                                                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                              color: offWhite,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary: redOrenge,
                                                                      ),
                                                                      onPressed: () async {
                                                                        Get.back();
                                                                        await Get.find<DbController>().deleteAssignedProduct(
                                                                          docId: Get.find<AdminChatController>().docId,
                                                                          productId: products[index].id,
                                                                        );
                                                                        await Get.find<AdminChatController>().fatchAssignedProducts();
                                                                        customBar(
                                                                          duration: 1,
                                                                          title: "Product Unassigned Successfully",
                                                                        );
                                                                      },
                                                                      child: Text(
                                                                        "Confirm",
                                                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                              color: offWhite,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              "Unassign Product",
                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                    color: offWhite,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(primary: slate),
                                                          onPressed: () => Get.back(),
                                                          child: Text(
                                                            "Cancel",
                                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                  color: offWhite,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                  } else {
                    return Center(
                      child: CustomProgressIndicator(),
                    );
                  }
                }),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            onTap: () {
              showBottomSheet(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  builder: (_) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: royal.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              // height: MediaQuery.of(context).size.height * 0.6,
                              child: StreamBuilder<List<Product>>(
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
                                      final products = snapshot.data;
                                      return GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.all(10),
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 200,
                                            childAspectRatio: 1 / 1.5,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemCount: products!.length,
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
                                                              height: 200,
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
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              loadingProgress.expectedTotalBytes!
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
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      splashColor: redOrenge.withOpacity(0.5),
                                                      borderRadius: BorderRadius.circular(10),
                                                      onLongPress: () {
                                                        Get.toNamed(
                                                          Routes.SHOW_PRODUCT,
                                                          arguments: products[index],
                                                        );
                                                      },
                                                      onTap: () {
                                                        Get.find<AdminAssignProductController>().rateController.text = products[index].rate;
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return AlertDialog(
                                                                actionsPadding: EdgeInsets.only(bottom: 20),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                backgroundColor: concrete,
                                                                title: GradientText(
                                                                  "Rate",
                                                                  colors: [redOrenge, royal, redOrenge],
                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                        fontSize: 20,
                                                                        letterSpacing: 2,
                                                                      ),
                                                                ),
                                                                content: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    CustomTextFormField(
                                                                      controller: Get.find<AdminAssignProductController>().rateController,
                                                                      keyboardType: TextInputType.number,
                                                                      prefix: Text(
                                                                        '₹',
                                                                        style: TextStyle(color: slate),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed: () => Get.back(),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                            color: offWhite,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed: () async {
                                                                      Get.back();

                                                                      await Get.find<AdminAssignProductController>()
                                                                          .assignProduct(products[index].id);
                                                                      await Get.find<AdminChatController>().fatchAssignedProducts();
                                                                      customBar(duration: 1, title: "Products Assigned Successfully");
                                                                    },
                                                                    child: Text(
                                                                      "Assign",
                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                            color: offWhite,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  } else {
                                    return Center(
                                      child: CustomProgressIndicator(),
                                    );
                                  }
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            label: "Assign Product",
          ),
        ),
      ],
    );
  }
}
