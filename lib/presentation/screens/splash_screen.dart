import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/core/services/data_cacher.dart';
import 'package:maya_coding_test/data/repositories/user_repository.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/screens/landing_screen.dart';
import 'package:maya_coding_test/presentation/screens/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final DataCacher _cacher = DataCacher.instance;
  final UserRepository _userRepository = UserRepository();
  Future<void> checkUser() async {
    final int? uid = _cacher.userUD;
    if (uid == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      final val = await _userRepository.getDetails(uid);
      ref.read(UserProviders.userDetailsProvider.notifier).update((r) => val);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkUser();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(
              backgroundColor: Platform.isIOS ? Colors.white : null,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
            const Gap(10),
            Text("Please wait"),
          ],
        ),
      ),
    );
  }
}
