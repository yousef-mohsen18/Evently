import 'package:evently_task/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class CustomContainerSign extends StatelessWidget {
  const CustomContainerSign({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
         Image.asset(AssetsManager.google,width: 24,height: 24,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: TextStyle(fontWeight: .w500, fontSize: 18,color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
