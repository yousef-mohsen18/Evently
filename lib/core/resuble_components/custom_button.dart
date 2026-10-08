import 'package:flutter/material.dart';

import '../resources/colors_manager.dart';
import '../resources/strings_manager.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key, required this.title,required this.onClick});
  final String title;
  Function()onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        Expanded(
          child: Container(
          height: 48,
          child: ElevatedButton(
            onPressed: onClick,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),

              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 20,
                color: ColorsManager.whiteColor,
              ),
            ),
          ),
                ),
        ),]
    );
  }
}
