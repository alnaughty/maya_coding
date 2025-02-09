import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/core/extensions/colors.dart';
import 'package:maya_coding_test/presentation/screens/send_money_screen.dart';
import 'package:maya_coding_test/presentation/widgets/success_bottomsheet.dart';

class SendMoneyBtn extends StatelessWidget {
  const SendMoneyBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SendMoneyScreen(
              onSucceed: () async {
                print("SHOW BOTTOM SHEET");
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.black.withNewOpacity(.5),
                  barrierLabel: "",
                  builder: (context) => SuccessBottomsheet(),
                );
              },
              onFail: () async {
                print("SHOW BOTTOM SHEET");
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.black.withNewOpacity(.5),
                  barrierLabel: "",
                  builder: (context) => SuccessBottomsheet(),
                );
              },
            ),
          ),
        );
        print("GO TO SEND MONEY SCREEN");
      },
      color: AppColor.scaffoldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(6),
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            AssetImage("assets/icons/payment.png"),
            color: Colors.white,
          ),
          const Gap(10),
          Text(
            "Send money",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    );
  }
}
