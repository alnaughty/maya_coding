import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/widgets/buttons/logout_button.dart';
import 'package:maya_coding_test/presentation/widgets/transaction_card.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final me = ref.watch(UserProviders.userDetailsProvider);
    final transactions = ref.watch(UserProviders.userTransactionProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [LogoutButton()],
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Transaction History"),
      ),
      body: transactions == null || transactions.isEmpty
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 10,
                children:
                    transactions.map((e) => TransactionCard(model: e)).toList(),
              ),
            ),
    );
  }
}
