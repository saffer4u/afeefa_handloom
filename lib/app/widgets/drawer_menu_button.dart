import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constents/colors.dart';

class DrawerMenuButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String title;
  const DrawerMenuButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          color: concrete,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
            splashColor: redOrenge,
            borderRadius: BorderRadius.circular(10),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // textBaseline: TextBaseline.ideographic,
                  children: [
                    Icon(
                      icon,
                      color: royal,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GradientText(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                      colors: [
                        royal,
                        redOrenge,
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
