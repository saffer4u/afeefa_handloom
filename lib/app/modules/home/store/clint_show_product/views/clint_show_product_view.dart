import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../../constents/colors.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/snakbars.dart';
import '../../../../../widgets/subtitle_widget.dart';
import '../../../../../widgets/title_widget.dart';
import '../controllers/clint_show_product_controller.dart';

class ClintShowProductView extends GetView<ClintShowProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TitleWidget(title: controller.product.title ?? 'Product'),
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
                        itemCount: controller.product.images.length,
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
                                      controller.product.images[index],
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
                  if (controller.product.colors.isNotEmpty) {
                    return Column(
                      children: [
                        SubTitleWidget(title: "In ${controller.product.colors.length} Colors"),
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
                                controller.product.title,
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
                              controller.product.id,
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
                                controller.product.weight.isEmpty ? "Unknown" : "${controller.product.weight} Grams",
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
                                controller.product.sizes.isEmpty ? "Unknown" : "${controller.product.sizes}",
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
                                controller.product.fabric.isEmpty ? "Unknown" : "${controller.product.fabric}",
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
                                "${controller.product.stock} PCS",
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
                                controller.product.description.isEmpty ? "Unknown" : "${controller.product.description}",
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
                        controller.product.rate.isNotEmpty
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
                                      "${controller.product.rate} ₹",
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
                    onTap: controller.askButtonPress,
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
                  child: Obx(() {
                    if (controller.isProductInCart.value) {
                      return GradientText(
                        'Already added in cart',
                        colors: [royal, redOrenge],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 20,
                            ),
                      );
                    } else {
                      return CustomButton(
                        onTap: () async {
                          if (controller.product.stock < 1) {
                            customBar(
                              title: "Not in stock",
                              message: "Please wait until product arrive",
                              duration: 2,
                            );
                          } else {
                            await controller.addToCart(ctx: context);
                          }
                        },
                        label: 'Add to Cart',
                        icon: Icons.shopping_cart_rounded,
                      );
                    }
                  }),
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
