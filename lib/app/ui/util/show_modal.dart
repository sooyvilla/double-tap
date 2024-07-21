import 'package:double_tap/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showModal(
  BuildContext context,
  Widget widget, {
  bool? isDismissible,
}) async {
  showModalBottomSheet(
      context: context,
      isDismissible: isDismissible ?? true,
      isScrollControlled: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: primaryGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget,
          ),
        );
      });
}

void showModalCupertino(BuildContext context, String name, Function onPressed) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text(
          'You are logout from $name',
          style: textNormal,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              onPressed();
              Navigator.pop(context);
            },
            child: Text(
              'Logout',
              style: textTitle.copyWith(
                color: primaryRed,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}
