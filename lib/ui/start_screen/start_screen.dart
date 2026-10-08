import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/colors_manager.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/core/resources/strings_manager.dart';
import 'package:evently_task/core/resuble_components/custom_button.dart';
import 'package:evently_task/ui/start_screen/widgets/elevate_container.dart';
import 'package:evently_task/ui/start_screen/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);

    final String nameChecked = "en";
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          AssetsManager.logo,
          color: Theme.of(context).colorScheme.primary,
          width: sizeWidth * .45,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Image.asset(
              AssetsManager.beingCreative,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(height: 24),
            Text(
              StringsManager.startTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              StringsManager.startDesc,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "${StringsManager.language}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Spacer(),
                ElevateContainer(
                  title: "English",
                  languageCode: "en",
                  selectedLanguage: nameChecked,
                ),
                ElevateContainer(
                  title: "Arabic",
                  languageCode: "ar",
                  selectedLanguage: nameChecked,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  StringsManager.theme,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Spacer(),
                ThemeSwitch(
                  imagePath: (ThemeMode.light == provider.themeMode)
                      ? AssetsManager.sunSelected
                      : AssetsManager.sun,
                  themeMode: ThemeMode.light,
                ),
                ThemeSwitch(
                  imagePath: (ThemeMode.dark == provider.themeMode)
                      ? AssetsManager.moonSelected
                      : AssetsManager.moon,
                  themeMode: ThemeMode.dark,
                ),
              ],
            ),
            Spacer(),
               Padding(
                padding: const EdgeInsets.only(bottom:28 ),
                child: CustomButton(title: StringsManager.startActionTitle, onClick: () { Navigator.of(context).pushReplacementNamed(RoutesManager.signup); },),
              ),
          ],
        ),
      ),
    );
  }
}
