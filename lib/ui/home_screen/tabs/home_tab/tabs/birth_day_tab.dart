import 'package:flutter/material.dart';

import '../../../../../core/remote/Network/fire_store_manager.dart';
import '../../../../../core/resources/app_constants.dart';
import '../../../../../model/fire_store/event_model.dart';
import '../../../widgets/event_item.dart';

class BirthDayTab extends StatelessWidget {
  const BirthDayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireStoreManager.getFilterEvents(AppConstants.type[1]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasError){
          print(" errorrr ${snapshot.error}");
        };
        List<EventModel> events = snapshot.data??[];

        return ListView.separated(
            itemBuilder: (context, index) {
              return EventItem(event: events[index]);
            }, separatorBuilder: (context, index) => SizedBox(height: 8,),
            itemCount: events.length
        );

      },
    );
  }
}
