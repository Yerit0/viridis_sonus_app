import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'Colors.dart';

InputDecoration inputDecoration({IconData? prefixIcon, String? hint, Color? bgColor, Color? borderColor, EdgeInsets? padding}) {
  return InputDecoration(
    contentPadding: padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: Offstage(),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: borderColor ?? PrimaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    ),
    fillColor: bgColor ?? PrimaryColor.withOpacity(0.04),
    hintText: hint,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: PrimaryColor) : null,
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
}