import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/strings_manager.dart';
import 'package:evently_task/core/resuble_components/custom_button.dart';
import 'package:evently_task/core/resuble_components/custom_text_filled.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              CustomTextFilled(hintText: "Enter your name", iconPrefixPath: AssetsManager.profile),
              SizedBox(height: 16),
              CustomTextFilled(hintText: "Enter your email", iconPrefixPath: AssetsManager.email),
            SizedBox(height: 16),
              CustomTextFilled(hintText: "Enter your password", iconPrefixPath: AssetsManager.lock,iconSuffixPath: AssetsManager.visibleOff,),
              SizedBox(height: 16),
              CustomTextFilled(hintText: "Confirm your password", iconPrefixPath: AssetsManager.lock,iconSuffixPath: AssetsManager.visibleOff),
              SizedBox(height: 75),
              CustomButton(title: "Sign Up", onClick: () {
                
              },)



            ],
          ),
        ),
      ),
    );
  }
}
