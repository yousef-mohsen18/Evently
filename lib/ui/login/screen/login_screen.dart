import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          color: Theme.of(context).colorScheme.primary,
          width: sizeWidth*.45,

        ),
      ),
    );
  }
}
