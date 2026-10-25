import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ScrollSelected extends StatelessWidget {
  final int index;
  bool isSelected;

  ScrollSelected({super.key, required this.index, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        curve: Curves.bounceIn,
        height: 7,
        width: isSelected? 30:8,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimaryFixedVariant,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
