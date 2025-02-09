import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/constants.dart';

class AppDropdown<XX> extends StatelessWidget {
  const AppDropdown(
      {super.key,
      required this.values,
      required this.onSelect,
      required this.labelText,
      this.hintText});
  final List<DropdownMenuItem<XX>> values;
  final ValueChanged<XX?> onSelect;
  final String labelText;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppConstants.fieldLabelStyle,
        ),
        const Gap(10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<XX>(
            items: values,
            onChanged: onSelect,
            hint: hintText == null
                ? null
                : Text(
                    hintText!,
                    style: AppConstants.hintStyle,
                  ),
            validator: (text) => text == null ? "Field is required" : null,
            style: AppConstants.fieldStyle
                .copyWith(color: Colors.white, fontFamily: "Poppins"),
          ),
        )
      ],
    );
  }
}
