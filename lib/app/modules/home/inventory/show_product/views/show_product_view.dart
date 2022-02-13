import 'package:afeefa_handloom/app/controllers/auth_controller.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/controllers/storage_controller.dart';
import 'package:afeefa_handloom/app/routes/app_pages.dart';
import 'package:afeefa_handloom/app/widgets/custom_button.dart';
import 'package:afeefa_handloom/app/widgets/custom_progress_indicator.dart';
import 'package:afeefa_handloom/app/widgets/custom_text_form_field.dart';
import 'package:afeefa_handloom/app/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../../constents/colors.dart';
import '../../../../../widgets/title_widget.dart';
import '../controllers/show_product_controller.dart';

class ShowProductView extends GetView<ShowProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TitleWidget(title: Get.arguments.title ?? 'Product'),
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
      body: Obx(
        () => ModalProgressHUD(
          opacity: 0.7,
          color: slate,
          progressIndicator: CustomProgressIndicator(),
          inAsyncCall: Get.find<AuthController>().isLoadig.value,
          child: SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [slate, concrete],
                  begin: Alignment(0, -1),
                  end: Alignment(0, 0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Show images card
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 300,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: Get.arguments.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ZoomOverlay(
                                    minScale: 1.5, // Optional
                                    maxScale: 3.0, // Optional
                                    twoTouchOnly: true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 2,
                                          color: offWhite,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          Get.arguments.images[index],
                                          height: 200,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(
                                              color: slate,
                                              height: 300,
                                              width: 100,
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
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    Divider(
                      height: 20,
                      color: royal.withOpacity(0.2),
                      thickness: 1,
                    ),
                    // Show colors card
                    Builder(builder: (context) {
                      if (Get.arguments.colors.isNotEmpty) {
                        return Column(
                          children: [
                            Container(
                              height: 50,
                              child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: Get.arguments.colors.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: HexColor(Get.arguments.colors[index]),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: offWhite,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    width: 50,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SubTitleWidget(title: "In ${Get.arguments.colors.length} Colors"),
                            Divider(
                              height: 20,
                              color: royal.withOpacity(0.2),
                              thickness: 1,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: offWhite,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GradientText(
                                  'Title : ',
                                  colors: [royal, redOrenge],
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 20,
                                      ),
                                ),
                                Expanded(
                                  child: Text(
                                    Get.arguments.title,
                                    style: TextStyle(
                                      height: 1,
                                      color: royal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GradientText(
                                  'ID : ',
                                  colors: [royal, redOrenge],
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                Text(
                                  Get.arguments.id,
                                  style: TextStyle(
                                    color: royal,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Get.arguments.weight.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GradientText(
                                        'Weight : ',
                                        colors: [royal, redOrenge],
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${Get.arguments.weight} Grams",
                                          style: TextStyle(
                                            height: 1,
                                            color: royal,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            Get.arguments.sizes.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GradientText(
                                        'Sizes : ',
                                        colors: [royal, redOrenge],
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${Get.arguments.sizes}",
                                          style: TextStyle(
                                            height: 1,
                                            color: royal,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            Get.arguments.fabric.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GradientText(
                                        'Fabric : ',
                                        colors: [royal, redOrenge],
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${Get.arguments.fabric}",
                                          style: TextStyle(
                                            height: 1,
                                            color: royal,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GradientText(
                                  'Stock : ',
                                  colors: [royal, redOrenge],
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${Get.arguments.stock} PCS",
                                    style: TextStyle(
                                      height: 1,
                                      color: royal,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Get.arguments.description.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GradientText(
                                        'Description : ',
                                        colors: [royal, redOrenge],
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${Get.arguments.description}",
                                          style: TextStyle(
                                            height: 1,
                                            color: royal,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            Get.arguments.rate.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GradientText(
                                        'Rate : ',
                                        colors: [royal, redOrenge],
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${Get.arguments.rate} ₹",
                                          style: TextStyle(
                                            height: 1,
                                            color: royal,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                        onTap: () => Get.toNamed(Routes.UPDATE_PRODUCT_INFO),
                        label: 'Update Info',
                        icon: Icons.upload,
                      ),
                    ),

                    Divider(
                      height: 20,
                      color: royal.withOpacity(0.2),
                      thickness: 1,
                    ),

                    // Share Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                        onTap: () async {
                          Get.find<AuthController>().isLoadig.value = true;
                          String shareText = "*${Get.arguments.title}*\n*Style No.* : ${Get.arguments.id}\n";
                          if (Get.arguments.weight.isNotEmpty) {
                            shareText = shareText + "*Weight* : ${Get.arguments.weight} Grams\n";
                          }
                          if (Get.arguments.sizes.isNotEmpty) {
                            shareText = shareText + "*Size* : ${Get.arguments.sizes}\n";
                          }

                          if (Get.arguments.fabric.isNotEmpty) {
                            shareText = shareText + "*Fabric* : ${Get.arguments.fabric}\n";
                          }

                          if (Get.arguments.colors.isNotEmpty) {
                            shareText = shareText + "*Colors* : ${Get.arguments.colors.length}\n";
                          }

                          if (Get.arguments.description.isNotEmpty) {
                            shareText = shareText + "*Description* : ${Get.arguments.description}\n";
                          }
                          // if (Get.arguments.rate.isNotEmpty) {
                          //   shareText = shareText + "*Rate* : ${Get.arguments.rate}";
                          // }

                          await Get.find<ShowProductController>().shareProduct(
                            Get.arguments.images,
                            shareText,
                          );
                          Get.find<AuthController>().isLoadig.value = false;
                        },
                        label: 'Share',
                        icon: Icons.share,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    // Share with rate button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                        onTap: () async {
                          TextEditingController rateController = TextEditingController();
                          rateController.text = Get.arguments.rate;
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
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
                                    controller: rateController,
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
                                    Get.find<AuthController>().isLoadig.value = true;
                                    String shareText = "*${Get.arguments.title}*\n*Style No.* : ${Get.arguments.id}\n";
                                    if (Get.arguments.weight.isNotEmpty) {
                                      shareText = shareText + "*Weight* : ${Get.arguments.weight} Grams\n";
                                    }
                                    if (Get.arguments.sizes.isNotEmpty) {
                                      shareText = shareText + "*Size* : ${Get.arguments.sizes}\n";
                                    }

                                    if (Get.arguments.fabric.isNotEmpty) {
                                      shareText = shareText + "*Fabric* : ${Get.arguments.fabric}\n";
                                    }

                                    if (Get.arguments.colors.isNotEmpty) {
                                      shareText = shareText + "*Colors* : ${Get.arguments.colors.length}\n";
                                    }

                                    if (Get.arguments.description.isNotEmpty) {
                                      shareText = shareText + "*Description* : ${Get.arguments.description}\n";
                                    }
                                    if (rateController.text.isNotEmpty) {
                                      shareText = shareText + "*Rate* : ${rateController.text} ₹";
                                    }

                                    await Get.find<ShowProductController>().shareProduct(
                                      Get.arguments.images,
                                      shareText,
                                    );
                                    Get.find<AuthController>().isLoadig.value = false;
                                  },
                                  child: Text(
                                    "Ok",
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
                        label: 'Share with rate',
                        icon: Icons.share,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Delete Product button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                        icon: Icons.delete,
                        onTap: () {
                          List<dynamic> imageUrls = Get.arguments.images;
                          String docId = Get.arguments.id;
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              actionsPadding: EdgeInsets.only(bottom: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: concrete,
                              title: GradientText(
                                "Delete",
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
                                    Get.find<AuthController>().isLoadig.value = true;
                                    await Get.find<ShowProductController>().deleteImages(imageUrls);
                                    await Get.find<DbController>().deleteProductFromDb(docId);
                                    Get.find<AuthController>().isLoadig.value = false;
                                    Get.back();
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
                        label: 'Delete Product',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
