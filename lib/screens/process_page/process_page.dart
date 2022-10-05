import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/controllers/c_where_status.dart';
import '../../models/laundry.dart';
import '../../styles/format.dart';
import '../../styles/layout.dart';
import '../status_page/status_page.dart';

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
      appBar: AppBar(
        title: Text('${widget.status} Orders'),
      ),
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
                child: ListTile(
                    onTap: () {
                      Get.off(() => StatusPage(laundry: laundry))?.then((value) {
                        if (value ?? false) {
                          refresh();
                        }
                    });
                  },
                  leading: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Layout.appRadius)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Layout.appSpacing / 4),
                      child: Image(
                        image: AssetImage('./assets/icons/${laundry.status!.toLowerCase()}.png'),
                        height: Layout.appSpacing * 5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  horizontalTitleGap: 15,
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Layout.appSpacing / 2,
                      Layout.appSpacing / 2,
                      Layout.appSpacing / 2,
                      Layout.appSpacing / 2,
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
                            style: Theme.of(Get.context!).textTheme.headline6!),
                        Text(
                            textScaleFactor: 0.6,
                            Format.time(laundry.queueDate!),
                            style: Theme.of(Get.context!).textTheme.headline6!),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
