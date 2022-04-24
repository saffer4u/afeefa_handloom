import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constents/colors.dart';
import '../../../../controllers/db_controller.dart';
import '../../../../widgets/title_widget.dart';
import '../controllers/admin_chat_controller.dart';
import 'admin_new_message_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: Get.find<DbController>().getUserMessageStream(docId: Get.find<AdminChatController>().docId),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(child: Center(child: TitleWidget(title: 'Something went wrong')));
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Expanded(child: Center(child: TitleWidget(title: "Say Hi 👋")));
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(child: Center(child: TitleWidget(title: "Loading...")));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            var data = snapshot.data!.docs[index];
                            // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            return Column(
                              crossAxisAlignment: data['byAdmin'] == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                                    ),
                                    // width: MediaQuery.of(context).size.width * 0.8,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: data['byAdmin'] == true ? slate : offWhite,
                                        borderRadius: data['byAdmin'] == true
                                            ? BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                            : BorderRadius.only(
                                                bottomRight: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )),
                                    child: Column(
                                      crossAxisAlignment: data['byAdmin'] == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['message'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: royal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          DateFormat.jm().format((data['createdAt'] as Timestamp).toDate()).toString(),
                                          style: TextStyle(
                                            height: 0.7,
                                            color: redOrenge.withOpacity(0.7),
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                },
              ),
              AdminNewMessageWidget(),
            ],
          )
       ;
  }
}