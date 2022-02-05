import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constents/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  String? Function(String?)? validator;
  TextInputType? keyboardType;

  CustomTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.characters,
      cursorColor: slate,
      cursorWidth: 2,
      cursorRadius: Radius.circular(50),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: royal,
            fontSize: 20,
          ),
      controller: controller,
      keyboardType: keyboardType??TextInputType.name,
      decoration: InputDecoration(
        // helperText: "Hello",
        labelText: labelText,
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 20,
        ),
        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: royal.withOpacity(0.4),
              fontSize: 15,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: slate,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: royal.withOpacity(0.6),
            width: 2.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: redOrenge.withOpacity(0.6),
            width: 2,
          ),
        ),
        errorMaxLines: 2,

        errorStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: redOrenge.withOpacity(0.8),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: redOrenge.withOpacity(0.8),
            width: 2.5,
          ),
        ),
      ),
    );
  }
}
