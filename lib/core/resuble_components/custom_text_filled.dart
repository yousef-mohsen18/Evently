import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFilled extends StatefulWidget {
  CustomTextFilled({
    super.key,
    required this.hintText,
    required this.iconPrefixPath,
    this.iconSuffixPath = "",
    required this.controller,
    required this.keyboardType,
    this.isPassword = false, required this.validation,
  });

  final String hintText;
  final String iconPrefixPath;
  final String iconSuffixPath;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)validation;

  @override
  State<CustomTextFilled> createState() => _CustomTextFilledState();
}

class _CustomTextFilledState extends State<CustomTextFilled> {
  bool visibleOff = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        errorStyle: TextStyle(color: Colors.red),
        fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red),
        ) ,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.displaySmall,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: SvgPicture.asset(widget.iconPrefixPath, width: 24, height: 24),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                style: IconButton.styleFrom(elevation: 0),
                onPressed: () {
                  setState(() {
                    visibleOff = !visibleOff;
                  });
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                  child: SvgPicture.asset(
                   visibleOff?AssetsManager.visibleOff:AssetsManager.visibleOn,
                    height: 24,
                    width: 24,
                  ),
                ),
              )
            : null,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword? visibleOff:false,

    );
  }
}
