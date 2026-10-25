import 'package:flutter/material.dart';

abstract class DialogUtils {
  static showMessageDialog({
    required String content,
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Warning"),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Text("Loading ..."),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
