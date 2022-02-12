import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/widgets/custom_button.dart';
import 'package:afeefa_handloom/app/widgets/custom_progress_indicator.dart';
import 'package:afeefa_handloom/app/widgets/custom_text_form_field.dart';
import 'package:afeefa_handloom/app/widgets/snakbars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../widgets/product_add_list_Image.dart';
import '../../../../widgets/product_colors_view_card.dart';
import '../../../../widgets/subtitle_widget.dart';
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
        child: Obx(() {
          if (Get.find<AuthController>().isLoadig.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomProgressIndicator(),
                SizedBox(height: 20),
                TitleWidget(title: "Adding Product please wait..."),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      // Product Images Card
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              color: Colors.grey,
                            ),
                          ], color: concrete, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                      child: GradientText(
                                        'Product Images',
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              color: royal,
                                              fontSize: 20,
                                              letterSpacing: 2,
                                            ),
                                        colors: [royal, redOrenge],
                                      ),
                                    )),
                                    ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(slate)),
                                      onPressed: () {
                                        Get.find<AddProductController>().picImages();
                                      },
                                      child: Icon(Icons.add_a_photo_outlined),
                                    ),
                                  ],
                                ),
                                Obx(() {
                                  if (Get.find<AddProductController>().croppedImageFileList.value.isNotEmpty) {
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
                      // Product Colors Card
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              color: Colors.grey,
                            ),
                          ], color: concrete, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                        child: GradientText(
                                          'Product Colors',
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                color: royal,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                              ),
                                          colors: [royal, redOrenge],
                                        ),
                                      )),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: slate,
                                        ),
                                        // Color Picker Button
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
                                                      color: Get.find<AddProductController>().pickedColor.value,
                                                    ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          GetBuilder<AddProductController>(
                                                            builder: (_) {
                                                              return SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: Get.find<AddProductController>().pickedColorList.value.map((data) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: GestureDetector(
                                                                        onLongPress: () {
                                                                          Get.find<AddProductController>().deleteColor(data);
                                                                          HapticFeedback.vibrate();
                                                                        },
                                                                        child: Container(
                                                                          height: 80,
                                                                          width: 80,
                                                                          decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                blurRadius: 2,
                                                                                offset: Offset(1, 1),
                                                                              ),
                                                                            ],
                                                                            borderRadius: BorderRadius.circular(15),
                                                                            border: Border.all(width: 4, color: Colors.white),
                                                                            color: HexColor(data),
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
                                                              Get.find<AddProductController>().pickedColor.value = color;
                                                            },
                                                            controller: Get.find<AddProductController>().colorController,
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              ElevatedButton(
                                                                style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all<Color>(
                                                                    Colors.black,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: Icon(Icons.done_all_rounded),
                                                              ),
                                                              ElevatedButton(
                                                                style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                                                ),
                                                                onPressed: () {
                                                                  Get.find<AddProductController>().addColor();
                                                                },
                                                                child: Icon(Icons.colorize_outlined),
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
                                    return Get.find<AddProductController>().pickedColorList.value.isNotEmpty
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
                                    if (Get.find<AddProductController>().pickedColorList.value.isNotEmpty) {
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
                      //product info card
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              color: Colors.grey,
                            ),
                          ], color: concrete, borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: Get.find<AddProductController>().formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and ID
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(
                                        validator: (val) {
                                          if (val!.length < 4) {
                                            return "Title length can't be less then 4";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: Get.find<AddProductController>().titleController,
                                        labelText: "Title*",
                                        capitalization: TextCapitalization.words,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomTextFormField(
                                        validator: (val) {
                                          if (val!.length < 4) {
                                            return "Id can't be less then 4 numbers";
                                          } else if (val.length > 4) {
                                            return "Id can't be greater then 4 numbers";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: Get.find<AddProductController>().idController,
                                        prefix: Text(
                                          "AH",
                                          style: TextStyle(color: slate),
                                        ),
                                        labelText: "ID*",
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Weight and Size
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        controller: Get.find<AddProductController>().weightController,
                                        prefix: Text(
                                          'Gm. ',
                                          style: TextStyle(color: slate),
                                        ),
                                        labelText: 'Weight',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(
                                        controller: Get.find<AddProductController>().sizeController,
                                        labelText: 'Size',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Fabric and rate
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(
                                        capitalization: TextCapitalization.words,
                                        controller: Get.find<AddProductController>().fabricController,
                                        labelText: 'Fabric',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomTextFormField(
                                        controller: Get.find<AddProductController>().rateController,
                                        keyboardType: TextInputType.number,
                                        labelText: 'Rate',
                                        prefix: Text(
                                          '₹',
                                          style: TextStyle(color: slate),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Description
                                CustomTextFormField(
                                  maxLines: 2,
                                  controller: Get.find<AddProductController>().descriptionController,
                                  labelText: "Description",
                                  capitalization: TextCapitalization.sentences,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomButton(
                          onTap: () async {
                            if (Get.find<AddProductController>().croppedImageFileList.value.isEmpty) {
                              customBar(duration: 2, title: "Please Select Images");
                            } else {
                              if (Get.find<AddProductController>().formKey.currentState!.validate()) {
                                Get.defaultDialog(
                                  title: "",
                                  contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                  content: Column(
                                    children: [
                                      Text(
                                        "Add Product",
                                        style: GoogleFonts.baloo(
                                          color: royal,
                                          fontSize: 35,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                  backgroundColor: slate,
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                          // Snakebars().errorBar(
                                          //     'This is a test message to test and design the snakebar.');
                                        },
                                        child: Text(
                                          'NO',
                                          style: GoogleFonts.baloo(
                                            color: royal.withOpacity(0.8),
                                            fontSize: 20,
                                          ),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          Get.back();
                                          Get.find<AuthController>().isLoadig.value = true;
                                          if (await Get.find<DbController>()
                                              .productExistCheck("AH${Get.find<AddProductController>().idController.text}")) {
                                            Get.find<AuthController>().isLoadig.value = false;
                                            customBar(
                                              title: "Product already exist",
                                              duration: 3,
                                              message: "A product with same id already exist please provide different id",
                                            );
                                          } else {
                                            await Get.find<DbController>().addProductToDb();
                                            Get.back();

                                            Get.find<AuthController>().isLoadig.value = false;
                                            customBar(duration: 2, title: "Product Added Successfully");
                                          }
                                        },
                                        child: Text(
                                          'YES',
                                          style: GoogleFonts.baloo(
                                            color: royal,
                                            fontSize: 20,
                                          ),
                                        )),
                                  ],
                                );
                              }
                            }
                          },
                          label: 'Add Product',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
