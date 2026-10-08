import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/strings_manager.dart';
import 'package:evently_task/core/resuble_components/custom_button.dart';
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

    bool secure=true;
  GlobalKey<FormState>formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.logo, width: sizeWidth * .45),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Form(
            key:  formKey,
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
                    if(value==null||value.isEmpty){
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
                    if (value==null||value.isEmpty){
                      return "invalid email";
                    }
                    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                      return"email error";
                    };
                  } ,
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
                    if(value!=passController.text){
                      return"password is not correct";
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  hintText: "Confirm your password",
                  iconPrefixPath: AssetsManager.lock,
                  iconSuffixPath:  AssetsManager.visibleOff,
                  controller: confirmPassController,
                ),
                SizedBox(height: 75),
                CustomButton(title: "Sign Up", onClick: () {
                  if(formKey.currentState!.validate()){
                    print("jfff");
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
