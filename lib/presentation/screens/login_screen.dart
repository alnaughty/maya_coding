import 'dart:io';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maya_coding_test/config/constants.dart';
import 'package:maya_coding_test/core/extensions/string.dart';
import 'package:maya_coding_test/config/app_color.dart';
import 'package:maya_coding_test/core/services/auth_services.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';
import 'package:maya_coding_test/data/repositories/user_repository.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';
import 'package:maya_coding_test/presentation/screens/landing_screen.dart';
import 'package:maya_coding_test/presentation/widgets/app_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static final TextEditingController _email = TextEditingController();
  static final TextEditingController _password = TextEditingController();

  static final AuthServices _services = AuthServices();
  static final UserRepository _repository = UserRepository();
  static final GlobalKey<FormState> _kForm = GlobalKey();
  bool isLoading = false;
  Future<void> login() async {
    dartz.Either<Exception, UserModel> result =
        await _services.login(email: _email.text, password: _password.text);
    result.fold((error) {
      if (error.toString().contains("User not found")) {
        Fluttertoast.showToast(msg: "User not found!");
        return;
      }
    }, (data) async {
      final val = await _repository.getDetails(data.id);
      ref.read(UserProviders.userDetailsProvider.notifier).update((r) => val);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            top: true,
            bottom: true,
            child: Form(
              key: _kForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  Text(
                    "Welcome",
                    style: AppConstants.titleStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Lets log you in!",
                  ),
                  const Gap(30),
                  AppTextfield.form(
                    labelText: "Email",
                    hintText: "@email.com",
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) => text == null || text.isEmpty
                        ? "Field is required"
                        : !text.isValidEmail
                            ? "Field must contain a valid email"
                            : null,
                  ),
                  const Gap(15),
                  AppTextfield.form(
                    labelText: "Password",
                    obscureText: true,
                    controller: _password,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    validator: (text) => text == null || text.isEmpty
                        ? "Field is required"
                        : null,
                  ),
                  const Gap(30),
                  MaterialButton(
                    disabledColor: AppColor.grey,
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_kForm.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await login();
                              isLoading = false;
                              if (mounted) setState(() {});
                            }
                          },
                    elevation: 0,
                    height: 45,
                    color: AppColor.purpleSwatch,
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator.adaptive(
                              backgroundColor:
                                  Platform.isIOS ? Colors.white : null,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
