import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../constents/colors.dart';
import '../../../../widgets/product_add_list_Image.dart';
import '../../../../widgets/product_colors_view_card.dart';
import '../../../../widgets/title_widget.dart';
import '../../create_edit_profile/views/create_edit_profile_view.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  final List<String> file = ['Aftab', 'Khan', 'Ansari', 'Pathan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TitleWidget(title: 'Add Product'),
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
        child: SingleChildScrollView(
            child: SafeArea(
          child: Center(
            // child: TextButton(
            //   child: TitleWidget(title: "Images"),
            //   onPressed: () {
            //     Get.find<AddProductController>().picImages();
            //   },
            // ),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            color: Colors.grey,
                          ),
                        ],
                        color: concrete,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        children: [
                          // Get.find<AddProductController>()
                          //         .croppedImageFileList
                          //         .value
                          //         .isNotEmpty
                          //     ? Obx(() => Image.file(
                          //         Get.find<AddProductController>()
                          //             .croppedImageFileList
                          //             .value[0]!))
                          //     : SizedBox.shrink(),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Center(
                                      child: SubTitleWidget(
                                          title: "Product Images"))),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            slate)),
                                onPressed: () {
                                  Get.find<AddProductController>().picImages();
                                },
                                child: Icon(Icons.add_a_photo_outlined),
                              ),
                            ],
                          ),

                          Obx(() {
                            if (Get.find<AddProductController>()
                                .croppedImageFileList
                                .value
                                .isNotEmpty) {
                              return ProductAddListImageWidget();
                            } else {
                              return SizedBox.shrink();
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        // top: 5,
                        ),
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            color: Colors.grey,
                          ),
                        ],
                        color: concrete,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Get.find<AddProductController>()
                          //         .croppedImageFileList
                          //         .value
                          //         .isNotEmpty
                          //     ? Obx(() => Image.file(
                          //         Get.find<AddProductController>()
                          //             .croppedImageFileList
                          //             .value[0]!))
                          //     : SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Center(
                                  child:
                                      SubTitleWidget(title: "Product Colors"),
                                )),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: slate,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      enableDrag: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Obx(() => Container(
                                              height: 700,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                                color: Get.find<
                                                        AddProductController>()
                                                    .pickedColor
                                                    .value,
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    GetBuilder<
                                                        AddProductController>(
                                                      builder: (_) {
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: Get.find<
                                                                    AddProductController>()
                                                                .pickedColorList
                                                                .value
                                                                .map((data) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onLongPress:
                                                                      () {
                                                                    Get.find<
                                                                            AddProductController>()
                                                                        .deleteColor(
                                                                            data);
                                                                    HapticFeedback
                                                                        .vibrate();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 80,
                                                                    width: 80,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                              2,
                                                                          offset: Offset(
                                                                              1,
                                                                              1),
                                                                        ),
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border: Border.all(
                                                                          width:
                                                                              4,
                                                                          color:
                                                                              Colors.white),
                                                                      color: HexColor(
                                                                          data),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CircleColorPicker(
                                                      strokeWidth: 10,
                                                      thumbSize: 50,
                                                      onChanged: (color) {
                                                        Get.find<
                                                                AddProductController>()
                                                            .pickedColor
                                                            .value = color;
                                                      },
                                                      controller: Get.find<
                                                              AddProductController>()
                                                          .colorController,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                              Colors.black,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Icon(Icons
                                                              .done_all_rounded),
                                                        ),
                                                        ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .black)),
                                                          onPressed: () {
                                                            Get.find<
                                                                    AddProductController>()
                                                                .addColor();
                                                          },
                                                          child: Icon(Icons
                                                              .colorize_outlined),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                  child: Icon(Icons.color_lens_outlined),
                                ),
                              ],
                            ),
                          ),

                          GetBuilder<AddProductController>(
                            builder: (_) {
                              return Get.find<AddProductController>()
                                      .pickedColorList
                                      .value
                                      .isNotEmpty
                                  ? Divider(
                                      height: 0,
                                      color: royal.withOpacity(0.2),
                                      thickness: 1,
                                    )
                                  : SizedBox.shrink();
                            },
                          ),

                          GetBuilder<AddProductController>(
                            builder: (_) {
                              if (Get.find<AddProductController>()
                                  .pickedColorList
                                  .value
                                  .isNotEmpty) {
                                return ProductColorsViewCard();
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
