import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/widgets/custom_button.dart';
import 'package:afeefa_handloom/app/widgets/custom_progress_indicator.dart';
import 'package:afeefa_handloom/app/widgets/custom_text_form_field.dart';
import 'package:afeefa_handloom/app/widgets/snakbars.dart';
import 'package:afeefa_handloom/app/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:afeefa_handloom/app/modules/home/create_edit_profile/controllers/create_edit_profile_controller.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/auth_controller.dart';

class ClintCreateProfile extends StatelessWidget {
  const ClintCreateProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: offWhite,
          ),
          // While uploading widget
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: concrete,
                    // gradient: LinearGradient(
                    //   colors: [
                    //     concrete,
                    //     offWhite,
                    //   ],
                    //   begin: Alignment(0, -1),
                    //   end: Alignment(0, 0),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GradientText(
                          'User Info',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: royal,
                                fontSize: 20,
                              ),
                          colors: [royal, redOrenge],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: redOrenge,
                                onTap: () => Get.find<CreateEditProfileController>().picImageSquare(ImageType.user),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                  child: Obx(
                                    () {
                                      if (Get.find<DbController>().userExist.value == true &&
                                          Get.find<CreateEditProfileController>().uploadImageFile.value == null) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.network(
                                            Get.find<DbController>().userProfile.value.profilePicUrl,
                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  backgroundColor: royal,
                                                  color: redOrenge,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        if (Get.find<CreateEditProfileController>().uploadImageFile.value != null) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: royal.withOpacity(0.6),
                                              ),
                                              borderRadius: BorderRadius.circular(17),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Image.file(Get.find<CreateEditProfileController>().uploadImageFile.value!),
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 40,
                                              ),
                                              Text(
                                                'Image',
                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                      color: royal,
                                                      fontSize: 10,
                                                    ),
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomTextFormField(
                                    validator: ((val) {
                                      if (val!.length < 5) {
                                        return "Name length can't be less than 5";
                                      } else {
                                        return null;
                                      }
                                    }),
                                    controller: Get.find<CreateEditProfileController>().userNameController,
                                    labelText: "Name",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      customBar(
                                        title: "Phone No. can not be changed",
                                        duration: 2,
                                      )
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: slate.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: royal.withOpacity(0.4), width: 2)),
                                      child: GradientText(
                                        "Phone No. ${Get.find<AuthController>().getPhoneNumber}",
                                        colors: [
                                          royal,
                                          redOrenge,
                                        ],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: concrete,
                    // gradient: LinearGradient(
                    //   colors: [
                    //     concrete,
                    //     offWhite,
                    //   ],
                    //   begin: Alignment(0, -1),
                    //   end: Alignment(0, 0),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GradientText(
                          'firm Info',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: royal,
                                fontSize: 20,
                              ),
                          colors: [royal, redOrenge],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: redOrenge,
                                onTap: () => Get.find<CreateEditProfileController>().picImageSquare(ImageType.logo),
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    child: Obx(
                                      () {
                                        if (Get.find<DbController>().userExist.value == true &&
                                            Get.find<CreateEditProfileController>().uploadLogoFile.value == null) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: Image.network(
                                              Get.find<DbController>().userProfile.value.logoUrl,
                                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    backgroundColor: royal,
                                                    color: redOrenge,
                                                    value: loadingProgress.expectedTotalBytes != null
                                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          if (Get.find<CreateEditProfileController>().uploadLogoFile.value != null) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: royal.withOpacity(0.6),
                                                ),
                                                borderRadius: BorderRadius.circular(17),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.file(Get.find<CreateEditProfileController>().uploadLogoFile.value!),
                                              ),
                                            );
                                          } else {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 40,
                                                ),
                                                Text(
                                                  'Logo',
                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                        color: royal,
                                                        fontSize: 10,
                                                      ),
                                                ),
                                              ],
                                            );
                                          }
                                        }
                                      },
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomTextFormField(
                                    validator: ((val) {
                                      if (val!.length < 5) {
                                        return "firm Name can't be less than 5 characters";
                                      } else {
                                        return null;
                                      }
                                    }),
                                    controller: Get.find<CreateEditProfileController>().firmNameController,
                                    labelText: 'firm Name',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    validator: ((val) {
                                      if (val!.length < 15) {
                                        return "GST No. can't be less than 15 digits";
                                      } else if (val.length > 15) {
                                        return "GST No. can't be greater than 15 digits";
                                      } else {
                                        return null;
                                      }
                                    }),
                                    controller: Get.find<CreateEditProfileController>().gstNumberController,
                                    labelText: "GST Number",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          // height: 40,
                          color: royal.withOpacity(0.2),
                          thickness: 1,
                        ),
                        GradientText(
                          'Bank Account Info',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: royal,
                                fontSize: 15,
                              ),
                          colors: [royal, redOrenge],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          labelText: "Bank Name ( Optional )",
                          controller: Get.find<CreateEditProfileController>().bankNameController,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          keyboardType: TextInputType.number,
                          labelText: "Account No. ( Optional )",
                          controller: Get.find<CreateEditProfileController>().accountNumberController,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          labelText: "IFSC Code ( Optional )",
                          controller: Get.find<CreateEditProfileController>().ifscCodeController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Divider(
          height: 30,
          color: royal.withOpacity(0.2),
          thickness: 1,
        ),
        CustomButton(
          onTap: () {
            if (Get.find<CreateEditProfileController>().uploadImageFile.value == null && !Get.find<DbController>().userExist.value) {
              customBar(
                title: "Please Select Profile Picture",
                duration: 2,
              );
            } else if (Get.find<CreateEditProfileController>().uploadLogoFile.value == null && !Get.find<DbController>().userExist.value) {
              customBar(
                title: "Please Select A Logo",
                duration: 2,
              );
            } else {
              if (Get.find<CreateEditProfileController>().formKey.currentState!.validate()) {
                // ! Impliment submit dialog
                Get.defaultDialog(
                  title: "",
                  contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  content: Column(
                    children: [
                      Text(
                        "Submit Details",
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

                          await Get.find<CreateEditProfileController>().createClintProfileModel();
                          Get.back();

                          Get.find<AuthController>().isLoadig.value = false;
                          customBar(
                            duration: 2,
                            message: Get.find<DbController>().userExist.value ? "" : "Restarting the application please wait...",
                            title: Get.find<DbController>().userExist.value ? "Profile Updated Successfully" : "Profile Created Successfully",
                          );

                          if (!Get.find<DbController>().userExist.value) {
                            await Future.delayed(
                              Duration(seconds: 3),
                            );
                            Restart.restartApp();
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
          label: Get.find<DbController>().userExist.value ? 'Update' : 'Submit',
        ),
      ],
    );
  }
}
