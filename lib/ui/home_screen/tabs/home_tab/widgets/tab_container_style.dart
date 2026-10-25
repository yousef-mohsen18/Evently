import 'package:evently_task/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabContainerStyle extends StatefulWidget {
  TabContainerStyle({
    super.key,
    required this.assetName,
    required this.title,
    required this.isSelected
  });

  String assetName;
  String title;
  bool isSelected;


  @override
  State<TabContainerStyle> createState() => _TabContainerStyleState();
}

class _TabContainerStyleState extends State<TabContainerStyle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: .center,
      decoration: BoxDecoration(
        color: widget.isSelected?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadiusGeometry.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          spacing: 4,
          children: [
            SvgPicture.asset(
              widget.assetName,
              height: 24,
              width: 24,
              colorFilter: widget.isSelected
                  ? .mode(Colors.white, .srcIn)
                  : .mode(Theme.of(context).colorScheme.primary,.srcIn)),

            Text(
              widget.title,
              style: widget.isSelected
                  ? Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: .w500,
                      fontSize: 16,
                    )
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
