import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFilled extends StatelessWidget {
   CustomTextFilled({super.key, required this.hintText, required this.iconPrefixPath, this.iconSuffixPath=""});
  final String hintText;
  final String iconPrefixPath;
  final String iconSuffixPath;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary)),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.displaySmall,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8),
          child: SvgPicture.asset(iconPrefixPath,width: 24,height: 24),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16,top: 8,bottom: 8),
          child: SvgPicture.asset(iconSuffixPath,height: 20,width: 20,),
        ),


        ),
    );
  }
}
