import 'package:evently_task/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  ThemeSwitch({super.key, required this.imagePath,required this.themeMode});
  final String imagePath;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {
          provider.changeTheme(themeMode);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: (themeMode==provider.themeMode)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        child: SvgPicture.asset(
            imagePath
      ),
    )
    );
  }
}
