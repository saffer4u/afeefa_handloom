import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constents/colors.dart';
import '../modules/home/add_product/controllers/add_product_controller.dart';

class ProductAddListImageWidget extends StatelessWidget {
  const ProductAddListImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 200,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: Get.find<AddProductController>()
                .croppedImageFileList
                .value
                .length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: slate,
                                border: Border.all(
                                  width: 3,
                                  color: slate,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.file(
                                      Get.find<AddProductController>()
                                          .croppedImageFileList
                                          .value[index]!),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(royal)),
                                        onPressed: () {
                                          Get.find<AddProductController>()
                                              .croppedImageFileList
                                              .update((val) {
                                            val!.removeAt(index);
                                          });
                                          Get.back();
                                        },
                                        child: Text(
                                          "Remove",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color:
                                                    redOrenge.withOpacity(0.8),
                                              ),
                                        )),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(royal)),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: concrete,
                                              ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(Get.find<AddProductController>()
                      .croppedImageFileList
                      .value[index]!),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
