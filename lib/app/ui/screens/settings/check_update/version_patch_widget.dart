import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../ui.dart';

class ShowListUpdatesNotesWidget extends StatelessWidget {
  const ShowListUpdatesNotesWidget({
    super.key,
    required this.updates,
    this.allUpdates = false,
  });

  final List<ResumePatch> updates;
  final bool allUpdates;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: allUpdates ? updates.length : 1,
      itemBuilder: (context, index) {
        final update = updates[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWithPadding(
                  text: update.title,
                  top: 0,
                  left: 5,
                  bottom: 5,
                  style: textTitle.copyWith(fontSize: 16),
                ),
                TextWithPadding(
                  text: update.version,
                  left: 0,
                  top: 0,
                  bottom: 5,
                  style: textNormalGrey.copyWith(
                    fontSize: 16,
                    color: Colors.green[200],
                  ),
                ),
              ],
            ),
            TextWithPadding(
              text: update.date,
              top: 0,
              left: 8,
              bottom: 5,
              style: textNormalGrey.copyWith(
                fontSize: 12,
              ),
            ),
            TextWithPadding(
              text: update.desc,
              top: 0,
              left: 8,
              style: textNormalGrey.copyWith(fontSize: 14),
            ),
          ],
        );
      },
    );
  }
}
