import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/app_color.dart';

class SuccessBottomsheet extends StatelessWidget {
  const SuccessBottomsheet({super.key, this.text = 'Money sent successfully'});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColor.scaffoldColor,
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
