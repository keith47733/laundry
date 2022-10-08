import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/controllers/c_home.dart';
import '../../../models/controllers/c_user.dart';
import '../../../models/process.dart';
import '../../../styles/format.dart';
import '../../../styles/layout.dart';
import '../../../theme/app_theme.dart';

Widget dailySummaryCard(
  BuildContext context,
  CUser cUser,
  CHome cHome,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing / 2,
      0,
      Layout.appSpacing / 2,
    ),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Layout.appSpacing,
          Layout.appSpacing / 2,
          Layout.appSpacing,
          Layout.appSpacing * 1.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                Layout.appSpacing / 2,
                0,
                Layout.appSpacing / 2,
              ),
              child: Obx(
                () {
                  if (cUser.data.id == null) return const Text('');
                  return Text(
                    '${cUser.data.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                },
              ),
            ),
            Text(
              '[ADMINISTRATOR]',
              textScaleFactor: 1.25,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                Layout.appSpacing / 2,
              ),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                Layout.appSpacing,
              ),
              child: Row(
                children: [
                  const Icon(Icons.navigate_before),
                  Text(
                    '   ${Format.date(DateTime.now())}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const Icon(Icons.navigate_next),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: lighten(Colors.green, 20),
                            borderRadius: BorderRadius.circular(Layout.appRadius),
                          ),
                          alignment: Alignment.center,
                          child: Obx(
                            () {
                              return Text(
                                cHome.analysis['Today'].toString(),
                                textScaleFactor: 4,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: lighten(color4, 80)),
                              );
                            }, // Obx builder
                          ),
                        ),
                      ),
                    ], // Column children
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        Process.listToday.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              Layout.appSpacing,
                              index == 0 ? 0 : Layout.appSpacing / 4,
                              0,
                              index == Process.listToday.length - 1 ? 0 : Layout.appSpacing / 2,
                            ),
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: lighten(color2, 75),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Layout.appRadius)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  Layout.appSpacing,
                                  Layout.appSpacing / 2,
                                  Layout.appSpacing,
                                  Layout.appSpacing / 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(Process.listToday[index], style: Theme.of(context).textTheme.bodyMedium),
                                    Obx(
                                      () {
                                        String statusKey = Process.listToday[index];
                                        return Text(cHome.analysis[statusKey].toString(),
                                            style: Theme.of(context).textTheme.bodyMedium);
                                      },
                                    ),
                                  ], // Row children
                                ),
                              ),
                            ),
                          );
                        }, // List.generate builder
                      ),
                    ),
                  ),
                ], // Row children
              ),
            ),
          ],
        ),
      ),
    ),
  ); // Column children
}
