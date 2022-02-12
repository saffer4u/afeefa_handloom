import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/modules/home/add_product/model/product.dart';
import 'package:afeefa_handloom/app/routes/app_pages.dart';
import 'package:afeefa_handloom/app/widgets/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constents/colors.dart';
import '../../../../widgets/subtitle_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../controllers/inventory_controller.dart';

class InventoryView extends GetView<InventoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Get.find<DbController>().getAllDocsOfCollection('products');
          // await Get.find<InventoryController>().getAllProducts();
          // Get.find<DbController>().readProduct();
          Get.offNamed(Routes.ADD_PRODUCT);
        },
        child: Icon(Icons.add),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TitleWidget(title: 'Inventory'),
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
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [slate, concrete],
              begin: Alignment(0, -1),
              end: Alignment(0, 0),
            ),
          ),
          child: StreamBuilder<List<Product>>(
            stream: Get.find<DbController>().readProduct(),
            builder: ((_, snapshot) {
              if (snapshot.hasError) {
                return Center(child: TitleWidget(title: "Something went wrong..."));
              } else if (snapshot.hasData) {
                final products = snapshot.data;
                return GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1 / 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: offWhite,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
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
                                        " Stock : ${'Impl.'}",
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
                                onTap: () {
                                  Get.toNamed(
                                    Routes.SHOW_PRODUCT,
                                    arguments: products[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return Center(
                  child: CustomProgressIndicator(),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
