import 'package:evently_task/core/remote/Network/fire_store_manager.dart';
import 'package:evently_task/core/resources/app_constants.dart';
import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:evently_task/core/resources/dialog_utils.dart';
import 'package:evently_task/model/fire_store/event_model.dart';
import 'package:evently_task/provider/theme_provider.dart';
import 'package:evently_task/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  EventItem({super.key, required this.event});

  final EventModel event;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      height: sizeHeight * .25,
      child: Stack(
        children: [
          Container(
            height: sizeHeight * .25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(
                  provider.themeMode == ThemeMode.light
                      ? AppConstants.lightImage[widget.event.type] ?? ""
                      : AppConstants.darkImage[widget.event.type] ?? "",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                Container(
                  padding: EdgeInsetsGeometry.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  child: Text(
                    widget.event.dateAndTime?.toDate().day.toString()??"",
                    style: TextStyle(
                      fontWeight: .w600,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsGeometry.only(left: 8, right: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        widget.event.title ?? "",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () {
                          heartSelected(userProvider);
                        },
                        icon: SvgPicture.asset(
                          userProvider.user?.favorites?.contains(widget.event.id)??false
                              ? AssetsManager.heart_selected
                              : AssetsManager.heart,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  heartSelected(UserProvider userProvider) async{

    if( userProvider.user?.favorites?.contains(widget.event.id)??false){
      await FireStoreManager.deleteEventFavorite(widget.event);
      userProvider.user?.favorites?.remove(widget.event.id!);
      await FireStoreManager.updateUser(userProvider.user?.favorites??[]);
      SnackBar snackBar = SnackBar(
        content: Text("Event deleted from list favorite"),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackBar);
      setState(() {

      });
    }
  else{
      DialogUtils.showLoadingDialog(context);
      await FireStoreManager.addEventFavorite(widget.event);
      userProvider.user?.favorites?.add(widget.event.id!);
      await FireStoreManager.updateUser(userProvider.user?.favorites??[]);
      Navigator.pop(context);
      SnackBar snackBar = SnackBar(
        content: Text("Event added to list favorite"),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackBar);
      setState(() {

      });
    };

  }



}
