import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CreateProfileWidget extends StatelessWidget {
  const CreateProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
        color: concrete,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: InkWell(
          splashColor: redOrenge,
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: royal,
                  child: Icon(
                    Icons.upload,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => GradientText(
                          Get.find<DbController>()
                              .userData
                              .value!['phoneNumber'],
                          colors: [
                            royal,
                            royal.withOpacity(0.7),
                          ],
                          style: TextStyle(fontSize: 15),
                        )),
                    GradientText(
                      'Create Profile',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 20),
                      colors: [royal, redOrenge],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
