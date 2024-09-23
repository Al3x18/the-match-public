import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:the_match/utils/globals.dart';

Future<int?> cupertinoRoundModalPopup(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return showCupertinoModalPopup<int>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: List.generate(
            38,
            (index) {
              return CupertinoContextMenuAction(
                  child: Text("Round ${index + 1}"),
                  onPressed: () => Get.back(result: index + 1));
            },
          ),
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel", style: TextStyle(color: isDark ? Colors.white : CUSTOM_BLUE_COLOR)),
            onPressed: () => Get.back(),
          ),
        );
      });
}

Future<int?> androidRoundPopMenu(BuildContext context) {
  return showMenu<int>(
    context: context,
    position: const RelativeRect.fromLTRB(100, 100, 100, 100),
    items: List.generate(
      38,
      (index) => PopupMenuItem<int>(
        value: index + 1,
        child: Text(
          "Round ${index + 1}",
        ),
      ),
    ),
  );
}
