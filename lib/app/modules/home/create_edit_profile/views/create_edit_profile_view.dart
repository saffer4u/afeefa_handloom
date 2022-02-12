import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/auth_controller.dart';
import 'clint_create_profile.dart';
import '../../../../widgets/custom_progress_indicator.dart';
import '../../../../widgets/subtitle_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../../../../widgets/unknown_create_profile.dart';
import '../controllers/create_edit_profile_controller.dart';

class CreateEditProfileView extends GetView<CreateEditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() =>
            Get.find<CreateEditProfileController>().isUserExist.value
                ? TitleWidget(title: "Update Profile")
                : TitleWidget(title: "Create Profile")),

        //  Get.find<DbController>().userData.value!['isProfileCompleted']
        //     ? TitleWidget(title: "Edit Profile")
        //     :
        //     Builder(
        //   builder: (_) {
        //     if (Get.find<DbController>().userExistCheck() == true) {
        //       return TitleWidget(title: "Create Profile");
        //     }else{
        //       return TitleWidget(title: "Update Profile");
        //     }
        //     ;
        //   },
        // ),

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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: Get.find<CreateEditProfileController>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SubTitleWidget(
                            title: 'User Type',
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // Dropdown button widget.
                          Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.grey,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: slate,
                              ),
                              child: DropdownButton(
                                iconEnabledColor: royal,
                                underline: SizedBox.shrink(),
                                dropdownColor: concrete,
                                borderRadius: BorderRadius.circular(12),
                                isDense: true,
                                items: Get.find<CreateEditProfileController>()
                                    .userTypeDropDownItems
                                    .map((String item) {
                                  return DropdownMenuItem(
                                    child: GradientText(
                                      item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                      colors: [
                                        royal,
                                        redOrenge,
                                      ],
                                    ),
                                    value: item,
                                  );
                                }).toList(),
                                value: Get.find<CreateEditProfileController>()
                                    .userTypeDropDownValue
                                    .value,
                                onChanged: (String? value) {
                                  Get.find<CreateEditProfileController>()
                                      .userTypeDropDownValue
                                      .value = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 40,
                        color: royal.withOpacity(0.2),
                        thickness: 1,
                      ),
                      Obx(() {
                        if (Get.find<AuthController>().isLoadig.value) {
                          return Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomProgressIndicator(),
                                SizedBox(
                                  height: 10,
                                ),
                                TitleWidget(title: "Please Wait...")
                              ],
                            ),
                          );
                        } else {
                          switch (Get.find<CreateEditProfileController>()
                              .userTypeDropDownValue
                              .value) {
                            case 'Clint':
                              return ClintCreateProfile();

                            default:
                              return UnknownCreateProfile();
                          }
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

