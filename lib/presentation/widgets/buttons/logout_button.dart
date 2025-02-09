import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/core/services/data_cacher.dart';
import 'package:maya_coding_test/presentation/providers/app_providers.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/screens/splash_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});
  static final DataCacher _cacher = DataCacher.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, c) {
      // final me =
      return TextButton.icon(
        onPressed: () async {
          ref
              .read(AppProviders.showBalanceProvider.notifier)
              .update((r) => false);
          ref.read(UserProviders.userBalanceProvider.notifier).update((r) => 0);
          ref
              .read(UserProviders.userDetailsProvider.notifier)
              .update((r) => null);
          ref
              .read(UserProviders.userTransactionProvider.notifier)
              .update((r) => null);
          await _cacher.removeID();
          await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SplashScreen()));
        },
        style:
            ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColor.red)),
        label: Text("Logout"),
        icon: Icon(
          Icons.logout,
          color: AppColor.red,
        ),
      );
    });
  }
}
