import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/core/extensions/date.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/core/services/data_cacher.dart';
import 'package:maya_coding_test/data/models/transaction.dart';
import 'package:maya_coding_test/data/repositories/balance_repository.dart';
import 'package:maya_coding_test/data/repositories/transaction_repository.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/widgets/balancer_card.dart';
import 'package:maya_coding_test/presentation/widgets/buttons/logout_button.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  final DataCacher _cacher = DataCacher.instance;
  StreamSubscription<List<TransactionModel>>? _streamSubscription;
  Stream<List<TransactionModel>>? _stream;

  Stream<double>? _streamBalance;
  StreamSubscription<double>? _streamBalanceSubscription;
  final TransactionRepository _repo = TransactionRepository();
  final BalanceRepository _bal = BalanceRepository();
  void initStream() {
    final int? uid = _cacher.userUD;
    if (uid == null) return;
    _stream = _repo.get(uid);
    _streamSubscription = _stream!.listen((onData) {
      ref
          .read(UserProviders.userTransactionProvider.notifier)
          .update((r) => onData);
    });
    _streamBalance = _bal.get(uid);
    _streamBalanceSubscription = _streamBalance!.listen((onData) {
      print("ON BALANCE DATA: $onData");
      ref
          .read(UserProviders.userBalanceProvider.notifier)
          .update((r) => onData);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initStream();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(UserProviders.userDetailsProvider);
    if (user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Platform.isIOS ? Colors.white : null,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          Badge.count(
            backgroundColor: AppColor.purpleSwatch,
            count: 2,
            textColor: Colors.white,
            offset: Offset(-5, 8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.white,
              ),
            ),
          )
        ],
        centerTitle: false,
        // leadingWidth: 80,
        leading: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset(
              "assets/images/profile_pic.png",
              fit: BoxFit.cover,
              height: 45,
              width: 45,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateTime.now().greeting,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            children: [
              // const Gap(10),
              BalancerCard(), const Gap(10),
              LogoutButton()
            ],
          ),
        ),
      ),
    );
  }
}
