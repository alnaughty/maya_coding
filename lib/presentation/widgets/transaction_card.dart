import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/core/extensions/num.dart';
import 'package:maya_coding_test/data/models/transaction.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.model});
  final TransactionModel model;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return Consumer(builder: (context, ref, child) {
        final me = ref.watch(UserProviders.userDetailsProvider);
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.grey, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: c.maxWidth * .45),
                      child: Text(
                        me!.id == model.senderID
                            ? "Money transferred to"
                            : "Money received from",
                        style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM. yyyy hh:mm aa')
                          .format(model.createdAt),
                      style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: c.maxWidth * .45),
                      child: Text(
                        me.id == model.senderID ? model.sentTo : model.sendBy,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "${model.senderID == me.id ? "-" : "+"}${model.amount.toAmount()}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
