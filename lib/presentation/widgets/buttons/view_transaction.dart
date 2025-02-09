import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/presentation/screens/transaction_screen.dart';

class ViewTransactionBtn extends StatelessWidget {
  const ViewTransactionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        print("GO TO TRANSACTION SCREEN");
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TransactionScreen(),
          ),
        );
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
            AssetImage("assets/icons/transaction.png"),
            color: Colors.white,
          ),
          const Gap(10),
          Text(
            "Transactions",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    );
  }
}
