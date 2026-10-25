import 'package:evently_task/core/resources/routes_manager.dart';
import 'package:evently_task/core/resuble_components/custom_button.dart';
import 'package:evently_task/ui/on_boarding/widgets/boarding_model.dart';
import 'package:evently_task/ui/on_boarding/widgets/scroll_sellected.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/resources/assets_manager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> data = [
    BoardingModel(
      text:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
      title: "Find Events That Inspire You",
      imagePath: AssetsManager.hotTrending,
    ),
    BoardingModel(
      text:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
      title: "Effortless Event Planning",
      imagePath: AssetsManager.illustration,
    ),
    BoardingModel(
      text:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",

      title: "Connect with Friends & Share Moments",
      imagePath: AssetsManager.beingCreative,
    ),
  ];

  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int position = 0;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          AssetsManager.logo,
          color: Theme.of(context).colorScheme.primary,
          width: sizeWidth * .45,
        ),
        centerTitle: true,
        actions: position ==2? null : [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                _controller.jumpToPage(data.length - 1);
              },
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
              scrollBehavior: ScrollBehavior(),
                itemCount: data.length,
                onPageChanged: (value) {
                  setState(() {
                    position = value;
                  });
                },
                controller: _controller,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Image.asset(
                          data[index].imagePath,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            ScrollSelected(index: 0, isSelected: position == 0),
                            ScrollSelected(index: 1, isSelected: position == 1),
                            ScrollSelected(index: 2, isSelected: position == 2),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          data[position].title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          data[position].text,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            position == 2
                ? CustomButton(
                    title: "Get started",
                    onClick: () {
                      finishOnboarding();
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(RoutesManager.signup);
                    },
                  )
                : CustomButton(
                    title: "Next",
                    onClick: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 10),
                        curve: Curves.bounceInOut,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
  }
}
