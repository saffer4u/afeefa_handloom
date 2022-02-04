import 'package:afeefa_handloom/app/modules/home/create_edit_profile/controllers/create_edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constents/colors.dart';

class ClintCreateProfile extends StatelessWidget {
  const ClintCreateProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(20),
        child: Container(
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
                Text(
                  'User Info',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: royal,
                        fontSize: 20,
                      ),
                ),
                Row(
                  children: [
                    CircleAvatar(),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: slate,
                            cursorWidth: 2,
                            cursorRadius: Radius.circular(50),
                            style: GoogleFonts.baloo2(
                              color: Colors.grey.shade900,
                              fontSize: 20,
                            ),
                            controller:Get.find<CreateEditProfileController>().userNameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              hintText: ' Phone Number',
                              hintStyle: GoogleFonts.baloo(
                                letterSpacing: 4,
                                color: Colors.grey.shade500,
                                fontSize: 25,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: redOrenge.withOpacity(0.6),
                                  width: 2.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: slate,
                                  width: 3.0,
                                ),
                              ),
                              prefix: Text(
                                "+91 ",
                                style: GoogleFonts.baloo(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Text("Phone number"),
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
    );
  }
}
