import 'package:double_tap/app/ui/theme/theme.dart';
import 'package:double_tap/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showModal(
  BuildContext context,
  Widget widget, {
  bool? isDismissible,
}) async {
  showModalBottomSheet(
    context: context,
    scrollControlDisabledMaxHeightRatio: 0.9,
    isDismissible: isDismissible ?? true,
    isScrollControlled: true,
    builder: (context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: primaryGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget,
        ),
      );
    },
  );
}

void showModalCupertino(
  BuildContext context,
  String name, {
  bool rememberAccount = false,
  Function? onPressedSecondary,
  required Function onPressedPrimary,
}) {
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
              onPressedPrimary();
              Navigator.pop(context);
            },
            child: Text(
              'Logout',
              style: textTitle.copyWith(
                color: primaryRed,
              ),
            ),
          ),
          if (rememberAccount)
            CupertinoActionSheetAction(
              onPressed: () {
                onPressedSecondary!();
                Navigator.pop(context);
              },
              child: Text(
                'Logout and remember',
                style: textTitle.copyWith(
                  color: Colors.blue[400],
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

Future<void> showAlertCupertino(
  BuildContext context,
  String title,
  String desc, {
  void Function()? onPressedPrimary,
  void Function()? onPressedSecondary,
  bool seconButton = false,
}) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: textTitle,
        ),
        content: Text(
          desc,
          style: textNormal,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(language.alertSession.buttonOk),
            onPressed: () {
              if (onPressedSecondary != null) {
                onPressedSecondary();
                return;
              }
              Navigator.of(context).pop();
            },
          ),
          if (seconButton)
            CupertinoDialogAction(
              child: Text(language.alertSession.buttonLogin),
              onPressed: () {
                if (onPressedPrimary != null) {
                  onPressedPrimary();
                  return;
                }
                Navigator.of(context).pop();
              },
            ),
        ],
      );
    },
  );
}
