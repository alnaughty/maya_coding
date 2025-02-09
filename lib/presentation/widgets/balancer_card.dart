import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/constants.dart';
import 'package:maya_coding_test/core/extensions/num.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/presentation/providers/app_providers.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/widgets/buttons/send_money.dart';
import 'package:maya_coding_test/presentation/widgets/buttons/view_transaction.dart';

class BalancerCard extends StatelessWidget {
  const BalancerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final bool isVisible = ref.watch(AppProviders.showBalanceProvider);
      final double balance = ref.watch(UserProviders.userBalanceProvider);
      return Container(
        decoration: BoxDecoration(
            color: AppColor.grey, borderRadius: BorderRadius.circular(10)),
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      balance.toAmount(isObscured: !isVisible),
                      style: AppConstants.titleStyle.copyWith(fontSize: 25),
                    ),
                    Text("Total Balance")
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(AppProviders.showBalanceProvider.notifier)
                        .update((r) => !isVisible);
                  },
                  icon: Icon(
                    isVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: SendMoneyBtn(),
                ),
                const Gap(10),
                Expanded(
                  child: ViewTransactionBtn(),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
