import 'package:evently_task/core/remote/Network/fire_store_manager.dart';
import 'package:evently_task/model/fire_store/event_model.dart';
import 'package:evently_task/ui/home_screen/widgets/event_item.dart';
import 'package:flutter/material.dart';


class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}


class _AllTabState extends State<AllTab> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireStoreManager.listenALlEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<EventModel> events = snapshot.data??[];
          if(events.isEmpty){
            return Center(
              child: Text("Not Events Found",style: TextStyle(
                fontWeight: .w600,
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary
              ),),
            );
          }
             else if(snapshot.hasError){
               print(" errorrr ${snapshot.error}");
             };

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
