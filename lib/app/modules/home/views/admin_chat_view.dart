import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/widgets/subtitle_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AdminChatView extends StatelessWidget {
  const AdminChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Get.find<DbController>().getUsersStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              shadowColor: Colors.grey,
              color: slate,
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
              ),
              // tileColor: offWhite,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            offset: Offset(
                              1,
                              1,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(11),
                        // border: Border.all(
                        //   color: offWhite,
                        // ),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          data['profilePicUrl'],
                          height: 50,
                          width: 50,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            offset: Offset(
                              1,
                              1,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(11),
                        // border: Border.all(
                        //   color: offWhite,
                        // ),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          data['logoUrl'],
                          height: 50,
                          width: 50,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubTitleWidget(title: data['userName']),
                          GradientText(
                            data['firmName'],
                            colors: [royal, redOrenge],
                            style: TextStyle(height: 0.9, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data['phoneNumber'],
                            style: TextStyle(height: 0.9, color: royal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
