import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/constants.dart';
import 'package:maya_coding_test/core/extensions/colors.dart';
import 'package:maya_coding_test/core/extensions/num.dart';
import 'package:maya_coding_test/core/extensions/string.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';
import 'package:maya_coding_test/data/repositories/balance_repository.dart';
import 'package:maya_coding_test/data/repositories/transaction_repository.dart';
import 'package:maya_coding_test/presentation/providers/app_providers.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/widgets/app_dropdown.dart';
import 'package:maya_coding_test/presentation/widgets/app_textfield.dart';
import 'package:maya_coding_test/presentation/widgets/buttons/logout_button.dart';

class SendMoneyScreen extends ConsumerStatefulWidget {
  const SendMoneyScreen(
      {super.key, required this.onSucceed, required this.onFail});
  final Function()? onSucceed;
  final Function()? onFail;
  @override
  ConsumerState<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends ConsumerState<SendMoneyScreen> {
  final BalanceRepository _balanceRepository = BalanceRepository();
  final TransactionRepository _transactionRepository = TransactionRepository();
  final TextEditingController _amount = TextEditingController();
  final GlobalKey<FormState> _kForm = GlobalKey();
  UserModel? selected;
  @override
  void dispose() {
    _amount.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final String min = 100.toAmount();
  final String max = 50000.toAmount();
  bool btnEnabled = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(UserProviders.userBalanceProvider);
    final me = ref.watch(UserProviders.userDetailsProvider);
    final users = ref.watch(AppProviders.userListFutureProvider);
    return PopScope(
      canPop: !isLoading,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text("Send Money"),
            actions: [LogoutButton()],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Text(
                        "Send money from your wallet",
                        style: AppConstants.titleStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                      const Gap(20),
                      Form(
                        key: _kForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextfield.form(
                                  onChanged: (text) {
                                    setState(() {
                                      btnEnabled = text.isNotEmpty;
                                    });
                                  },
                                  labelText: "Amount",
                                  controller: _amount,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  validator: (text) => text == null ||
                                          text.isEmpty
                                      ? "Field is required"
                                      : !text.isValidMoneyAmount()
                                          ? "Field must contain a valid monetary value"
                                          : double.parse(text) < 100
                                              ? "Amount should be greater than $min"
                                              : double.parse(text) > balance
                                                  ? "Amount must not exceed your balance (${balance.toAmount()})"
                                                  : double.parse(text) > 50000
                                                      ? "Amount must not exceed $max"
                                                      : null,
                                  hintText: "Enter amount",
                                ),
                                const Gap(10),
                                Text(
                                  "From $min up to $max only",
                                  style: TextStyle(
                                      color: Colors.white.withNewOpacity(.6)),
                                ),
                              ],
                            ),
                            users.when(
                              data: (data) {
                                if (data.isEmpty) {
                                  return Column(
                                    children: [
                                      const Gap(15),
                                      Text(
                                        "NO USERS FOUND",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    const Gap(15),
                                    AppDropdown<UserModel>(
                                        hintText: "Select from these users",
                                        values: data
                                            .map(
                                              (e) =>
                                                  DropdownMenuItem<UserModel>(
                                                value: e,
                                                child: Text(e.name),
                                              ),
                                            )
                                            .toList(),
                                        onSelect: (value) {
                                          setState(() {
                                            selected = value;
                                          });
                                        },
                                        labelText: "Send to"),
                                  ],
                                );
                              },
                              error: (error, s) => Container(),
                              loading: () => Container(),
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Text(
                        "A 2% Convenience Fee will be deducted from the amount",
                        style:
                            TextStyle(color: Colors.white.withNewOpacity(.6)),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: btnEnabled
                        ? isLoading
                            ? null
                            : () async {
                                if (_kForm.currentState!.validate()) {
                                  try {
                                    final double value =
                                        double.parse(_amount.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await Future.wait([
                                      _balanceRepository.decrease(
                                        me!.id,
                                        value,
                                      ),
                                      _balanceRepository.increase(
                                          selected!.id, value),
                                      _transactionRepository.add(
                                        sender: me.toUserModel(),
                                        receiver: selected!,
                                        amount: value,
                                      ),
                                    ]);

                                    isLoading = false;
                                    if (mounted) setState(() {});

                                    Navigator.of(context).pop();
                                    if (widget.onSucceed != null) {
                                      widget.onSucceed!();
                                    }
                                  } catch (e) {
                                    if (widget.onFail != null) {
                                      widget.onFail!();
                                    }
                                  }
                                }
                              }
                        : null,
                    elevation: 0,
                    disabledColor: AppColor.purpleSwatch.withNewOpacity(.2),
                    height: 50,
                    color: AppColor.purpleSwatch,
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: btnEnabled ? Colors.white : AppColor.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
