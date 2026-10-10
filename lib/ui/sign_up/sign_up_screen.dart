import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/core/resources/strings_manager.dart';
import 'package:evently_task/core/resuble_components/custom_button.dart';
import 'package:evently_task/core/resuble_components/custom_container_sign.dart';
import 'package:evently_task/core/resuble_components/custom_text_filled.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  bool secure = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          width: sizeWidth * .45,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 47),
                Text(
                  StringsManager.createAccTitle,
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
                      return "invalid name";
                    }
                  },
                  keyboardType: TextInputType.name,
                  hintText: "Enter your name",
                  iconPrefixPath: AssetsManager.profile,
                  controller: nameController,
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
                SizedBox(height: 16),
                CustomTextFilled(
                  validation: (value) {
                    if (value != passController.text) {
                      return "password is not correct";
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  hintText: "Confirm your password",
                  iconPrefixPath: AssetsManager.lock,
                  iconSuffixPath: AssetsManager.visibleOff,
                  controller: confirmPassController,
                ),
                SizedBox(height: 75),
                CustomButton(
                  title: "Sign Up",
                  onClick: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 0,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(RoutesManager.login);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
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
                SizedBox(height: 24),
                CustomContainerSign(title: "Sign up With Google",)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
