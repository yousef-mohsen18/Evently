import 'package:easy_localization/easy_localization.dart';
import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
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

    late String nameChecked;

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
            SizedBox(height: 10),
            Text(
              "startTitle".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "startDesc".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "language".tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Spacer(),
                ElevateContainer(
                  title: "English",
                  languageCode: "en",
                  selectedLanguage: context.locale.languageCode,
                  onClicked: (){
                   context.setLocale(Locale("en"));
                  },
                ),

                ElevateContainer(
                  title: "Arabic",
                  languageCode: "ar",
                  selectedLanguage: context.locale.languageCode,
                  onClicked: () {
                     context.setLocale(Locale("ar"));
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "theme".tr(),
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
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomButton(
                title: "startActionTitle".tr(),
                onClick: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(RoutesManager.onBoarding);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
