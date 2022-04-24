import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/modules/home/admin_chat/controllers/admin_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constents/colors.dart';
import '../../../../widgets/custom_text_form_field.dart';

class AdminNewMessageWidget extends StatelessWidget {
  const AdminNewMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          FloatingActionButton(
            heroTag: "btn3",
            backgroundColor: royal,
            mini: true,
            onPressed: () async {
              await Get.find<AdminChatController>().fatchAssignedProducts();
            },
            child: Icon(
              Icons.attach_file_rounded,
              color: offWhite,
              size: 20,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: Get.find<AdminChatController>().messageController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              cursorColor: royal,
              cursorWidth: 2,
              cursorRadius: Radius.circular(50),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: royal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
              decoration: InputDecoration(
                // helperText: "Hello",

                // isCollapsed: true,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 15,
                ),
                // labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                //       color: royal.withOpacity(0.4),
                //       fontSize: 15,
                //     ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: royal.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: royal,
                    width: 2.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: redOrenge.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                errorMaxLines: 3,

                errorStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: redOrenge.withOpacity(0.8),
                    ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: redOrenge.withOpacity(0.8),
                    width: 2.5,
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: "btn4",
            backgroundColor: royal,
            mini: true,
            onPressed: Get.find<AdminChatController>().sendMessage,
            child: Icon(
              Icons.send,
              color: offWhite,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
