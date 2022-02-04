import 'package:afeefa_handloom/app/constents/colors.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final void Function()? onTap;
  const LogoutButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
          Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: royal.withOpacity(0.9),
          ),
          Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: royal.withOpacity(0.5),
          ),
          Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: royal.withOpacity(0.2),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Log Out',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 17,
                  color: royal,
                ),
          ),
          // Icon(
          //   Icons.arro,
          //   size: 20,
          //   color: redOrenge.withOpacity(0.5),
          // )
        ],
      ),
    );
  }
}
