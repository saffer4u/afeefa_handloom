import 'package:flutter/material.dart';

import '../constents/colors.dart';

class SubTitleWidget extends StatelessWidget {
  String title;
  SubTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: royal,
            fontSize: 20,
          ),
    );
  }
}
