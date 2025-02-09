import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/constants.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String labelText;
  final bool isFormField;
  const AppTextfield({
    super.key,
    required this.labelText,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
  })  : validator = null,
        isFormField = false;

  const AppTextfield.form({
    super.key,
    required this.labelText,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    required this.validator,
    this.onChanged,
  }) : isFormField = true;

  @override
  Widget build(BuildContext context) {
    final InputDecoration _decoration = InputDecoration(
      hintText: hintText,
      hintStyle: AppConstants.hintStyle,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppConstants.fieldLabelStyle,
        ),
        const Gap(10),
        if (isFormField) ...{
          TextFormField(
            controller: controller,
            style: AppConstants.fieldStyle.copyWith(
              color: Colors.white,
            ),
            cursorHeight: 12,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            decoration: _decoration,
          )
        } else ...{
          TextField(
            controller: controller,
            style: AppConstants.fieldStyle.copyWith(
              color: Colors.white,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: _decoration,
          )
        },
      ],
    );
    // return isFormField
    // ?
    // : TextField(
    //     controller: controller,
    //     obscureText: obscureText,
    //     keyboardType: keyboardType,
    //     onChanged: onChanged,
    //     decoration: _decoration,
    //   );
  }
}
