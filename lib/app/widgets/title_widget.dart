import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientText(
      title,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 25,
          ),
      colors: [royal, redOrenge],
    );
  }
}
