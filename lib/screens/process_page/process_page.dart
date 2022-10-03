import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/controllers/c_where_status.dart';
import '../../models/laundry.dart';
import '../../theme/layout.dart';
import '../../utils/format.dart';
import '../detail_page/detail_page.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key, required this.status});

  final String status;

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  final cWhereStatus = Get.put(CWhereStatus());

  refresh() {
    cWhereStatus.setList(widget.status);
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft(widget.status),
      body: GetBuilder<CWhereStatus>(
        builder: (_) {
          if (_.list.isEmpty) {
            return const Center(
              child: Image(
                image: AssetImage('./assets/icons/no orders.png'),
                height: Layout.appSpacing * 2.5,
                fit: BoxFit.cover,
              ),
            );
          }
          return ListView.builder(
            itemCount: _.list.length,
            itemBuilder: ((context, index) {
              Laundry laundry = _.list[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  Layout.appSpacing,
                  Layout.appSpacing / 2,
                  Layout.appSpacing,
                  0,
                ),
                child: Card(
                  elevation: Layout.cardElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Layout.appRadius),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Layout.appRadius),
                    ),
                    // tileColor: Palette.palette[200],
                    onTap: () {
                      Get.to(() => DetailPage(laundry: laundry))?.then((value) {
                        if (value ?? false) {
                          refresh();
                        }
                      });
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(Layout.appRadius),
                      child: Ink(
                        decoration: ShapeDecoration(
                          // color: Colors.white.withOpacity(0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Layout.appRadius)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image(
                            image: AssetImage('./assets/icons/${laundry.status!.toLowerCase()}.png'),
                            height: Layout.appSpacing * 2.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    horizontalTitleGap: 15,
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Layout.appSpacing / 2,
                        Layout.appSpacing / 2,
                        Layout.appSpacing / 2,
                        Layout.appSpacing / 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              textScaleFactor: 0.75,
                              laundry.customerName!,
                              style: Theme.of(Get.context!).textTheme.headline6!),
                        ],
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Layout.appSpacing / 2,
                        Layout.appSpacing / 4,
                        Layout.appSpacing / 2,
                        Layout.appSpacing / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textScaleFactor: 0.6,
                            Format.date(laundry.queueDate!),
                            style: Theme.of(Get.context!).textTheme.headline6,
                          ),
                          Text(
                            textScaleFactor: 0.6,
                            Format.time(laundry.queueDate!),
                            style: Theme.of(Get.context!).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
