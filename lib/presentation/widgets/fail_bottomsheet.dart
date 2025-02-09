import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/app_color.dart';

class FailBottomSheet extends StatelessWidget {
  const FailBottomSheet({super.key, this.text = 'Failed to send money'});
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
                      color: AppColor.red,
                    ),
                    child: Icon(
                      Icons.close,
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
