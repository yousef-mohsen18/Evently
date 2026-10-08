import 'package:evently_task/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/colors_manager.dart';

class ElevateContainer extends StatelessWidget {
   ElevateContainer({
    super.key,
    required this.title,
    required this.languageCode,
     required this.selectedLanguage
  });

  final String title;
  final String languageCode;
  final String selectedLanguage;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: (languageCode==selectedLanguage)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        child: Text(
          title,
          style:((languageCode==selectedLanguage))?  Theme.of(context).textTheme.labelMedium: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
