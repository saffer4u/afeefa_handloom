import 'package:flutter/material.dart';

import 'package:afeefa_handloom/app/constents/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const CustomButton({
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
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 17,
              color: royal,
            ),
      ),
    );
  }
}
