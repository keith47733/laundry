import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/controllers/c_home.dart';
import '../../../models/controllers/c_user.dart';
import '../../../models/process.dart';
import '../../../styles/format.dart';
import '../../../styles/layout.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/card_title.dart';

Widget dailySummaryCard(
  BuildContext context,
  CUser cUser,
  CHome cHome,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      0,
      Layout.appSpacing,
      0,
      0,
    ),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Layout.appSpacing,
          0,
          Layout.appSpacing,
          Layout.appSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  if (cUser.data.id == null) return const Text('');
                  return cardTitle('${cUser.data.name}');
                }),
                Text(
                  '[ADMINISTRATOR]',
                  textScaleFactor: 0.6,
                  style: Theme.of(Get.context!).textTheme.headline6,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                Layout.appSpacing,
              ),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: Layout.appSpacing,
              ),
              child: Row(
                children: [
                  const Icon(Icons.navigate_before),
                  Text(
                    '   ${Format.date(DateTime.now())}',
                    textScaleFactor: 0.9,
                    style: Theme.of(Get.context!).textTheme.headline6,
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
                            color: lighten(color2, 30),
                            borderRadius: BorderRadius.circular(Layout.appRadius),
                          ),
                          alignment: Alignment.center,
                          child: Obx(
                            () {
                              return Text(
                                cHome.analysis['Today'].toString(),
                                style: Theme.of(context).textTheme.headline3,
                              );
                            }, // Obx builder
                          ),
                        ),
                      ),
                    ], // Column children
                  ),
                  DView.spaceWidth(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        Process.listToday.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              index == 0 ? 0 : 4,
                              0,
                              index == Process.listToday.length - 1 ? 0 : 4,
                            ),
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: lighten(color2, 75),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Layout.appRadius)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(Process.listToday[index]),
                                    Obx(
                                      () {
                                        String statusKey = Process.listToday[index];
                                        return Text(cHome.analysis[statusKey].toString());
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
          ], // Column children
        ),
      ),
    ),
  );
}
