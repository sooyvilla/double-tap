import 'package:flutter/material.dart';
import 'package:insane_bolt/app/ui/theme/theme.dart';

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
