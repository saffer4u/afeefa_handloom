import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../../constents/colors.dart';
import '../../../../../controllers/auth_controller.dart';
import '../../../../../controllers/db_controller.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_progress_indicator.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/snakbars.dart';
import '../../../../../widgets/subtitle_widget.dart';
import '../../../../../widgets/title_widget.dart';
import '../../../inventory/show_product/controllers/show_product_controller.dart';
import '../../../inventory/show_product/views/show_product_view.dart';
import '../controllers/clint_show_product_controller.dart';

class ClintShowProductView extends GetView<ClintShowProductController> {
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
      body: SafeArea(
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
                              SizedBox(
                                width: 10,
                              ),
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
                // Product details card
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
                        // Title
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
                        // Id
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
                        // Weight
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,

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
                                Get.arguments.weight.isEmpty ? "Unknown" : "${Get.arguments.weight} Grams",
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
                        // Sizes
                        Row(
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
                                Get.arguments.sizes.isEmpty ? "Unknown" : "${Get.arguments.sizes}",
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
                        // Fabric
                        Row(
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
                                Get.arguments.fabric.isEmpty ? "Unknown" : "${Get.arguments.fabric}",
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
                        // Stock
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
                        // Description
                        Row(
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
                                Get.arguments.description.isEmpty ? "Unknown" : "${Get.arguments.description}",
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
                        // Rate
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

                Divider(
                  height: 20,
                  color: royal.withOpacity(0.2),
                  thickness: 1,
                ),

                // Ask Button
                // TODO: Impliment Ask functionality
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(

                    onTap: () async {},
                    label: 'Ask',
                    icon: Icons.speaker_notes_rounded,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // Add to cart button
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
                            "Quantity",
                            colors: [redOrenge, royal, redOrenge],
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                                      controller: rateController,
                                      keyboardType: TextInputType.number,
                                      prefix: Text(
                                        '₹',
                                        style: TextStyle(color: slate),
                                      ),
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
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: offWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {},
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
                    label: 'Add to Cart',
                    icon: Icons.shopping_cart_rounded,
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
    );
  }
}
