import 'package:easy_localization/easy_localization.dart';
import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/colors_manager.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/core/resuble_components/custom_container_sign.dart';
import 'package:evently_task/provider/theme_provider.dart';
import 'package:evently_task/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool  mode=false;
  late bool themeMode;

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of<ThemeProvider>(context);
    UserProvider userProvider=Provider.of<UserProvider>(context);

    double sizeH=MediaQuery.of(context).size.height;
    double sizeW=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: .infinity,
          width: .infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                SizedBox(height: 32,),
                Container(
                  height: sizeH*0.12,
                  width: sizeW*0.27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100) ,
                    image: DecorationImage(image: AssetImage(AssetsManager.route),fit: .fill)
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  userProvider.user?.name??"",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 20),
                ),
                SizedBox(height: 6,),
                Text(
                  FirebaseAuth.instance.currentUser?.email??"",
                  style: Theme.of(context).textTheme.displaySmall,
                ),

                SizedBox(height: 32,),
                Container(
                  height: 55,
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                  alignment: .center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    border: Border.all( color: Theme.of(context).colorScheme.tertiary,width: 1 )
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                           Text("Dark Mode",style: Theme.of(context).textTheme.bodyMedium,),
                           CupertinoSwitch(
                             activeTrackColor: ColorsManager.darkPrimary ,
                             value: provider.themeMode == ThemeMode.dark,
                             onChanged: (value) {

                               provider.changeTheme(
                                 value?ThemeMode.dark:ThemeMode.light
                               );

                             },

                           )
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  height: 55,
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                  alignment: .center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    border: Border.all( color: Theme.of(context).colorScheme.tertiary,width: 1 )
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                           Text("Language",style: Theme.of(context).textTheme.bodyMedium,),
                           IconButton(onPressed: () {
                            showModalBottomSheet(context: context, builder: (context) =>
                                Column(
                                  mainAxisSize: .min,

                              children: [
                                ListTile(
                                  title: const Text('English'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.setLocale(Locale("en"));

                                  },
                                ),
                                ListTile(
                                  title: const Text('العربية'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.setLocale(Locale("ar"));

                                  },
                                ),
                              ],
                            ),);
                           }, icon: SvgPicture.asset(AssetsManager.arrowRight,colorFilter: .mode(Theme.of(context).colorScheme.primary, .srcIn),))
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  height: 55,
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                  alignment: .center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    border: Border.all( color: Theme.of(context).colorScheme.tertiary,width: 1 )
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text("Logout",style: Theme.of(context).textTheme.bodyMedium,),
                      IconButton(onPressed: () {
                        FirebaseAuth.instance.signOut();
                      }, icon: SvgPicture.asset(AssetsManager.logout))
                     ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}
