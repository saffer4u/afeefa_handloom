import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constents/colors.dart';
import '../controllers/db_controller.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String url;
  final String headerText;

  const CustomNetworkImageWidget({
    Key? key,
    required this.url,
    required this.headerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: slate.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          height: 20,
          width: 80,
          child: Center(
            child: GradientText(
              headerText,
              colors: [royal, redOrenge],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: slate,
            border: Border.all(width: 4, color: slate),
            boxShadow: [
              BoxShadow(
                // spreadRadius: 3,
                color: Colors.black38,
                blurRadius: 4,
                offset: Offset(1, 1),
              ),
            ],
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
          ),
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            child: Stack(
              children: [
                Image.network(
                  url,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: royal,
                        color: redOrenge,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    splashColor: redOrenge,
                    onTap: (() {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      width: 5,
                                      color: slate,
                                    )),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    url,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: royal,
                                          color: redOrenge,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
