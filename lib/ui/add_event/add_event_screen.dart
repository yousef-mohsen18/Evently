import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_task/core/remote/Network/fire_store_manager.dart';
import 'package:evently_task/core/resources/app_constants.dart';
import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resuble_components/custom_button.dart';
import 'package:evently_task/model/fire_store/event_model.dart';
import 'package:evently_task/provider/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../home_screen/tabs/home_tab/widgets/tab_container_style.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int indexSelected = 0;

  bool isSelectedIndex0 = true;
  bool isSelectedIndex1 = false;
  bool isSelectedIndex2 = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    titleController = TextEditingController();
    descController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add event",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Container(
              alignment: .center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryFixed,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              child: SvgPicture.asset(
                AssetsManager.back,
                height: 24,
                width: 24,
                colorFilter: .mode(
                  Theme.of(context).colorScheme.onPrimary,
                  .srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: sizeHeight * .25,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(
                              provider.themeMode == ThemeMode.light
                                  ? AssetsManager.sport_light
                                  : AssetsManager.sport_dark,
                            ),
                            fit: .fill,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(
                              provider.themeMode == ThemeMode.light
                                  ? AssetsManager.birthday_light
                                  : AssetsManager.birthday_dark,
                            ),
                            fit: .fill,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(
                              provider.themeMode == ThemeMode.light
                                  ? AssetsManager.birthday_light
                                  : AssetsManager.birthday_dark,
                            ),
                            fit: .fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              TabBar(
                dividerHeight: 0,
                tabAlignment: .start,
                isScrollable: true,
                padding: EdgeInsetsGeometry.only(left: 0),
                onTap: (value) {
                  setState(() {
                    indexSelected = value;
                    if (value == 0) {
                      isSelectedIndex0 = true;
                      isSelectedIndex1 = false;
                      isSelectedIndex2 = false;
                    } else if (value == 1) {
                      isSelectedIndex0 = false;
                      isSelectedIndex1 = true;
                      isSelectedIndex2 = false;
                    } else if (value == 2) {
                      isSelectedIndex0 = false;
                      isSelectedIndex1 = false;
                      isSelectedIndex2 = true;
                    }
                  });
                },
                tabs: [
                  Tab(
                    child: TabContainerStyle(
                      assetName: AssetsManager.sportIcon,
                      isSelected: isSelectedIndex0,
                      title: "Sport",
                    ),
                  ),
                  Tab(
                    child: TabContainerStyle(
                      assetName: AssetsManager.birthdayIcon,
                      isSelected: isSelectedIndex1,
                      title: "Birthday",
                    ),
                  ),
                  Tab(
                    child: TabContainerStyle(
                      assetName: AssetsManager.meetingIcon,
                      isSelected: isSelectedIndex2,
                      title: "Meeting",
                    ),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Title",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          filled: true,
                          errorStyle: TextStyle(color: Colors.red),
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: "Event Title",
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                        ),
                        onTapOutside: (event) {
                          Duration(milliseconds: 2);
                          FocusScope.of(context).unfocus();
                        },
                        keyboardType: .name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Event title can't be empty";
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: descController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          filled: true,
                          errorStyle: TextStyle(color: Colors.red),
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: "Event Description",
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                        ),
                        onTapOutside: (event) {
                          Duration(milliseconds: 2);
                          FocusScope.of(context).unfocus();
                        },
                        keyboardType: .name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description can't be empty";
                          }
                        },
                      ),

                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          SvgPicture.asset(
                            height: 24,
                            width: 24,
                            AssetsManager.date,
                            colorFilter: .mode(
                              Theme.of(context).colorScheme.primary,
                              .srcIn,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Event Date",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              chooseDate();
                            },
                            child: Text(
                              selectedDate != null
                                  ? selectedDate.toString()
                                  : "Choose date",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          SvgPicture.asset(
                            height: 24,
                            width: 24,
                            AssetsManager.time,
                            colorFilter: .mode(
                              Theme.of(context).colorScheme.primary,
                              .srcIn,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Event Time",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              chooseTime();
                            },
                            child: Text(
                              selectedTime != null
                                  ? selectedTime?.format(context) ?? ""
                                  : "Choose time",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        title: "Add Event",
                        onClick: () {
                          if (formKey.currentState!.validate()) {
                            if (selectedTime != null || selectedDate != null) {
                              addEvent();
                              SnackBar snackBar = SnackBar(
                                content: Text("Event added to list"),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            } else {
                              SnackBar snackBar = SnackBar(
                                content: Text("Warning"),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  chooseDate() async {
    var temp = await showDatePicker(
      initialDate: selectedDate,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (temp != null) {
      setState(() {
        selectedDate = temp;
      });
    }
  }

  TimeOfDay? selectedTime;

  chooseTime() async {
    var temp = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (temp != null) {
      setState(() {
        selectedTime = temp;
      });
    }
  }

  addEvent() async {
    await FireStoreManager.saveEvent(
      EventModel(
        title: titleController.text,
        userId: FirebaseAuth.instance.currentUser?.uid,
        desc: descController.text,
        type: AppConstants.type[indexSelected],
        dateAndTime: Timestamp.fromDate(
          DateTime(
            selectedDate!.year,
            selectedDate!.month,
            selectedDate!.day,
            selectedTime!.hour,
            selectedTime!.minute,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
