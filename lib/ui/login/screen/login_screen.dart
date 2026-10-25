import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/routes_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resuble_components/custom_button.dart';
import '../../../core/resuble_components/custom_container_sign.dart';
import '../../../core/resuble_components/custom_text_filled.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController confirmPassController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          color: Theme.of(context).colorScheme.primary,
          width: sizeWidth * .45,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 47),
                  Text(
                    StringsManager.loginAccTitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                      fontWeight: .w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomTextFilled(
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "invalid email";
                      }
                      if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value)) {
                        return "email error";
                      }
                      ;
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter your email",
                    iconPrefixPath: AssetsManager.email,
                    controller: emailController,
                  ),
                  SizedBox(height: 16),
                  CustomTextFilled(
                    validation: (value) {
                      if (value!.length < 6) {
                        return 'Password must be more than 6 characters';
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter your password",
                    isPassword: true,
                    iconPrefixPath: AssetsManager.lock,
                    iconSuffixPath: AssetsManager.visibleOff,
                    controller: passController,
                  ),
                  SizedBox(height: 75),
                  CustomButton(
                    title: "Login",
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        LoginAcc();
                      }
                    },
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 0,
                    children: [
                      Text(
                        "Don’t have an account ?",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(RoutesManager.signup);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        child: Divider(
                          height: 1,
                          radius: BorderRadius.circular(1),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: .w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          height: 2,
                          radius: BorderRadius.circular(1),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  CustomContainerSign(
                    title: "Login With Google",
                    OnClick: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  LoginAcc() async {
    try {
      DialogUtils.showLoadingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(RoutesManager.homeScreen);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        DialogUtils.showMessageDialog(
          content: "No user found for that email.",
          context: context,
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMessageDialog(
          content: "Wrong password provided for that user.",
          context: context,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
