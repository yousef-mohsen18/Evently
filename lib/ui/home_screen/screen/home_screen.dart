import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/colors_manager.dart';
import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/ui/home_screen/tabs/favorite_tab.dart';
import 'package:evently_task/ui/home_screen/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../tabs/home_tab/screen/home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 0,

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: .w400,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          color: ColorsManager.unSelectedNavigation,
          fontWeight: .w400,
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              AssetsManager.home,
              colorFilter: .mode(ColorsManager.unSelectedNavigation, .srcIn),
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.home_selected,
              colorFilter: .mode(Theme.of(context).colorScheme.primary, .srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: "Favorite",
            icon: SvgPicture.asset(
              AssetsManager.heart,
              colorFilter: .mode(ColorsManager.unSelectedNavigation, .srcIn),
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.heart_selected,
              colorFilter: .mode(Theme.of(context).colorScheme.primary, .srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset(AssetsManager.profile),
            activeIcon: SvgPicture.asset(
              AssetsManager.profile_selected,
              colorFilter: .mode(Theme.of(context).colorScheme.primary, .srcIn),
            ),
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutesManager.addEvent);
        },
        child: SvgPicture.asset(AssetsManager.add,)),
    );
  }
}
