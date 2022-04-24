import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:afeefa_handloom/app/controllers/db_controller.dart';
import 'package:afeefa_handloom/app/routes/app_pages.dart';
import 'package:afeefa_handloom/app/widgets/subtitle_widget.dart';
import 'package:afeefa_handloom/app/widgets/title_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AdminChatWidget extends StatelessWidget {
  const AdminChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Get.find<DbController>().getUsersStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: TitleWidget(title: 'Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: TitleWidget(title: "Loading..."));
        }

        return ListView(
          physics: BouncingScrollPhysics(),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            final docId = document.id;
            return Stack(
              children: [
                Card(
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
                            child: Image.network(data['profilePicUrl'], height: 50, width: 50,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: royal,
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                            }),
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
                            child: Image.network(data['logoUrl'], height: 50, width: 50,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: royal,
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                            }),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: SubTitleWidget(
                                      title: data['userName'],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: GradientText(
                                      data['firmName'],
                                      colors: [royal, redOrenge],
                                      style: TextStyle(height: 1, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    data['phoneNumber'],
                                    style: TextStyle(height: 0.9, color: royal),
                                  ),
                                ],
                              ),
                              data['isAdmin']
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(color: concrete, borderRadius: BorderRadius.circular(5)),
                                      child: GradientText(
                                        "ADMIN",
                                        colors: [
                                          royal,
                                          redOrenge,
                                        ],
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 1,
                                          ),
                                          decoration: BoxDecoration(color: concrete, borderRadius: BorderRadius.circular(5)),
                                          child: GradientText(
                                            data['userType'],
                                            colors: [
                                              royal,
                                              redOrenge,
                                            ],
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        data['isVarified']
                                            ? CircleAvatar(
                                                radius: 15,
                                                child: Icon(
                                                  Icons.done_all_rounded,
                                                  color: Colors.greenAccent,
                                                ),
                                                backgroundColor: slate.withOpacity(1),
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: redOrenge.withOpacity(0.4),
                        onTap: () {
                          Get.toNamed(Routes.ADMIN_CHAT, arguments: [docId, data]);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
