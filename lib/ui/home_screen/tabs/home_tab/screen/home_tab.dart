import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/provider/theme_provider.dart';
import 'package:evently_task/provider/user_provider.dart';
import 'package:evently_task/ui/home_screen/tabs/home_tab/tabs/all_tab.dart';
import 'package:evently_task/ui/home_screen/tabs/home_tab/tabs/birth_day_tab.dart';
import 'package:evently_task/ui/home_screen/tabs/home_tab/tabs/meeting.dart';
import 'package:evently_task/ui/home_screen/tabs/home_tab/tabs/sport_tab.dart';
import 'package:evently_task/ui/home_screen/tabs/home_tab/widgets/tab_container_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late ThemeMode themeMode = ThemeMode.light;
  final currentUser = FirebaseAuth.instance.currentUser;

  bool isSelectedIndex0 = true;
  bool isSelectedIndex1 = false;
  bool isSelectedIndex2 = false;
  bool isSelectedIndex3 = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    ThemeProvider provider = Provider.of<ThemeProvider>(context);

    List<Widget> tabs = [AllTab(), SportTab(), BirthDayTab(), MeetingTab()];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: .start,

                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "Welcome Back ✨",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(height: 5),
                        Text(
                          userProvider.user?.name ?? "",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(fontWeight: .w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (provider.themeMode == ThemeMode.light) {
                                provider.changeTheme(ThemeMode.dark);
                              } else {
                                provider.changeTheme(ThemeMode.light);
                              }
                            });
                          },
                          icon: SvgPicture.asset(
                            provider.themeMode == .light
                                ? AssetsManager.sun
                                : AssetsManager.moon,
                            height: 24,
                            width: 24,
                            colorFilter: .mode(
                              Theme.of(context).colorScheme.primary,
                              .srcIn,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "En",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                TabBar(
                  dividerHeight: 0,
                  tabAlignment: .start,
                  isScrollable: true,
                  padding: EdgeInsetsGeometry.only(left: 0),
                  onTap: (value) {
                    setState(() {
                      if (value == 0) {
                        isSelectedIndex0 = true;
                        isSelectedIndex1 = false;
                        isSelectedIndex2 = false;
                        isSelectedIndex3 = false;
                      } else if (value == 1) {
                        isSelectedIndex0 = false;
                        isSelectedIndex1 = true;
                        isSelectedIndex2 = false;
                        isSelectedIndex3 = false;
                      } else if (value == 2) {
                        isSelectedIndex0 = false;
                        isSelectedIndex1 = false;
                        isSelectedIndex2 = true;
                        isSelectedIndex3 = false;
                      } else if (value == 3) {
                        isSelectedIndex0 = false;
                        isSelectedIndex1 = false;
                        isSelectedIndex2 = false;
                        isSelectedIndex3 = true;
                      }
                    });
                  },
                  tabs: [
                    Tab(
                      child: TabContainerStyle(
                        assetName: AssetsManager.allIcon,
                        isSelected: isSelectedIndex0,
                        title: "All",
                      ),
                    ),
                    Tab(
                      child: TabContainerStyle(
                        assetName: AssetsManager.sportIcon,
                        isSelected: isSelectedIndex1,
                        title: "Sport",
                      ),
                    ),
                    Tab(
                      child: TabContainerStyle(
                        assetName: AssetsManager.birthdayIcon,
                        isSelected: isSelectedIndex2,
                        title: "Birthday",
                      ),
                    ),
                    Tab(
                      child: TabContainerStyle(
                        assetName: AssetsManager.meetingIcon,
                        isSelected: isSelectedIndex3,
                        title: "Meeting",
                      ),
                    ),
                  ],
                ),
                SizedBox(height:24 ,),
                Expanded(child: TabBarView(children: tabs)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
