import 'package:flutter/material.dart';

import 'package:afeefa_handloom/app/constents/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final String label;
  const CustomButton({
    this.icon,
    Key? key,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      splashColor: redOrenge,
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: slate,
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 17,
                  color: royal,
                ),
          ),
          icon != null
              ? Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.share,
                      size: 15,
                      color: royal,
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
