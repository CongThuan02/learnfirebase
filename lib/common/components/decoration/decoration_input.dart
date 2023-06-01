import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_color.dart';

InputDecoration decorationInput({
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? hintText,
  String? errorText,
  required bool? required,
  required bool filled,
  required Color borderFocus,
  required bool readOnly,
  required Color enabledBorderColor,
  required Color borderColor,
  required Color errorColor,
  required String lable,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: readOnly ? const Icon(Icons.edit_off, color: AppColor.disable) : suffixIcon,
    filled: true,
    fillColor: Colors.white,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1,
        color: readOnly ? AppColor.disable : borderFocus,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1,
        color: AppColor.disable,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1,
        color: enabledBorderColor,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          width: 1,
          color: errorColor,
        )),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1,
        color: errorColor,
      ),
    ),
    hintText: hintText,
    label: RichText(
      text: TextSpan(
        text: lable,
        style: TextStyle(
          color: AppColor.textDefault,
          fontSize: 23.0.sp,
        ),
        children: <TextSpan>[
          TextSpan(
            text: required == true ? "(*)" : "",
          ),
          const TextSpan(text: ':'),
        ],
      ),
    ),
    errorText: errorText,
  );
}
