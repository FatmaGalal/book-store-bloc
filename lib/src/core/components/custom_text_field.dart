import 'package:book_store/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.maxLines = 1,
    required this.hint,
    this.onSaved,
    this.onChanged,
    this.text,
  });
  final int maxLines;
  final String hint;
  final String? text;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onSaved: onSaved,

      decoration: InputDecoration(
        hintText: hint,
        focusedBorder: builderBorder(kPrimaryColor),
        enabledBorder: builderBorder(),
        focusColor: kPrimaryColor,
        border: builderBorder(),
      ),
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      initialValue: text,
    );
  }

  OutlineInputBorder builderBorder([color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? kDefaultTextFieldBorderColor),

      borderRadius: BorderRadius.circular(6),
    );
  }
}
