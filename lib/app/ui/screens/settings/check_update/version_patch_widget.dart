import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../ui.dart';
import '../../../util/util.dart';

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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allUpdates ? updates.length : 1,
      itemBuilder: (context, index) {
        final update = updates[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextWithPadding(
                    text: update.title,
                    top: 0,
                    left: 5,
                    bottom: 5,
                    style: textTitle.copyWith(fontSize: 16),
                  ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextWithPadding(
                      text: update.date,
                      left: 8,
                      top: 0,
                      bottom: 5,
                      style: textNormalGrey.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        TextWithPadding(
                          text: 'Instalacion: ',
                          top: 0,
                          right: 0,
                          bottom: 0,
                          style: textNormalGrey.copyWith(fontSize: 14),
                        ),
                        TextWithPadding(
                          text: update.isImportant ? 'Automatica' : 'Manual',
                          top: 0,
                          left: 0,
                          bottom: 0,
                          style: textNormalGrey.copyWith(
                            fontSize: 14,
                            color:
                                update.isImportant ? Colors.green : Colors.red,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        TextWithPadding(
                          text: 'Estado: ',
                          left: 0,
                          top: 0,
                          right: 0,
                          bottom: 5,
                          style: textNormalGrey.copyWith(fontSize: 14),
                        ),
                        TextWithPadding(
                          text: update.isInactive ? 'Inactivo' : 'Activo',
                          left: 0,
                          top: 0,
                          bottom: 5,
                          style: textNormalGrey.copyWith(
                            fontSize: 14,
                            color:
                                update.isInactive ? Colors.red : Colors.green,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TextWithPadding(
              text: update.desc,
              top: 0,
              left: 8,
              bottom: 0,
              style: textNormalGrey.copyWith(fontSize: 14),
            ),
            if (!allUpdates)
              ButtonPrimary(
                text: 'Motrar todas las actualizaciones',
                top: 0,
                onPressed: () {
                  showModal(
                    context,
                    SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextWithPadding(
                              text: 'Todas las actualizaciones',
                              top: 0,
                              left: 0,
                              bottom: 5,
                              style: textTitle,
                            ),
                            ShowListUpdatesNotesWidget(
                              updates: updates,
                              allUpdates: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (allUpdates && index != updates.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: DividerCustom(
                  ident: 0,
                ),
              )
          ],
        );
      },
    );
  }
}
