import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/controllers/c_home.dart';
import '../../models/controllers/c_user.dart';
import '../../models/process.dart';
import '../../styles/format.dart';
import '../../styles/layout.dart';
import '../../styles/app_theme.dart';

Widget dailySummaryCard(
  BuildContext context,
  CUser cUser,
  CHome cHome,
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(Layout.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () {
              if (cUser.data.id == null) return const Text('');
              return Text(
                '${cUser.data.name}',
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
          const SizedBox(height: Layout.SPACING / 2),
          Text(
            '[ADMINISTRATOR]',
            textScaleFactor: 1.15,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: Layout.SPACING / 2),
          const Divider(thickness: 2.0),
          const SizedBox(height: Layout.SPACING / 2),
          Text(
            Format.date(DateTime.now()),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: Layout.SPACING),
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
                          borderRadius: BorderRadius.circular(Layout.RADIUS),
                        ),
                        alignment: Alignment.center,
                        child: Obx(
                          () {
                            return Text(
                              cHome.analysis['Today'].toString(),
                              textScaleFactor: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: lighten(color4, 80)),
                            );
                          }, // Obx builder
                        ),
                      ),
                    ),
                  ], // Column children
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            Layout.SPACING,
                            index == 0 ? 0 : Layout.SPACING / 4,
                            0,
                            index == Process.STATUS_DESC.length - 2
                                ? 0
                                : Layout.SPACING / 4,
                          ),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: lighten(color2, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Layout.RADIUS)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Layout.SPACING / 2,
                                horizontal: Layout.SPACING,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Process.SUMMARY_DESC[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Obx(
                                    () {
                                      String desc = '';
                                      if (index == 0) {
                                        desc = 'Queued';
                                      }
                                      if (index == 1) {
                                        desc = 'Processing';
                                      }
                                      if (index == 2) {
                                        desc = 'Complete';
                                      }
                                      return Text(
                                          cHome.analysis[desc].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium);
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
  );
}
