import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/remote/Network/fire_store_manager.dart';
import '../../../model/fire_store/event_model.dart';
import '../widgets/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(onPressed: () {
        
                }, icon: SvgPicture.asset(AssetsManager.search,colorFilter: .mode(Theme.of(context).colorScheme.primary,.srcIn))),
                errorStyle: TextStyle(color: Colors.red),
                fillColor: Theme
                    .of(
                  context,
                )
                    .colorScheme
                    .onPrimaryContainer,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .tertiary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .tertiary,
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
                hintStyle: Theme
                    .of(context)
                    .textTheme
                    .displaySmall,
              ),
              onTapOutside: (event) {
                Duration(milliseconds: 2);
                FocusScope.of(context).unfocus();
              },
              keyboardType: .name,
        
            ),
            SizedBox(height: 16,),
            Expanded(
              child: StreamBuilder(
                stream: FireStoreManager.listenFavorite(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<EventModel> events = snapshot.data ?? [];
                  if (events.isEmpty) {
                    return Center(
                      child: Text("Not Events Found", style: TextStyle(
                          fontWeight: .w600,
                          fontSize: 24,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary
                      ),),
                    );
                  }
                  else if (snapshot.hasError) {
                    print(" errorrr ${snapshot.error}");
                  };
        
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return EventItem(event: events[index]);
                      }, separatorBuilder: (context, index) => SizedBox(height: 8,),
                      itemCount: events.length
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}