import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/controllers/c_where_status.dart';
import '../../models/laundry.dart';
import '../../models/process.dart';
import '../../styles/format.dart';
import '../../styles/layout.dart';
import '../status_page/status_page.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key, required this.status});

  final int status;

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  // final cWhereStatus = Get.put(CWhereStatus());

  refresh() async {
    final cWhereStatus = Get.put(CWhereStatus());
    await cWhereStatus.setList(widget.status);
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Process.STATUS_DESC[widget.status])),
      body: GetBuilder<CWhereStatus>(
        builder: (order) {
          if (order.list.isEmpty) {
            return Center(
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  './assets/icons/no orders.png',
                  height: MediaQuery.of(context).size.width * 0.50,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(
                top: Layout.SPACING,
                left: Layout.SPACING * 2,
                right: Layout.SPACING * 2,
                bottom: Layout.SPACING * 2),
            child: ListView.builder(
              itemCount: order.list.length,
              itemBuilder: (context, index) {
                Laundry laundry = order.list[index];
                return Padding(
                  padding: const EdgeInsets.only(top: Layout.SPACING),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: Layout.SPACING / 2,
                      horizontal: Layout.SPACING,
                    ),
                    dense: true,
                    onTap: () {
                      Get.off(() => StatusPage(laundry: laundry));
                    },
                    leading: Image.asset(
                      './assets/icons/laundry${(laundry.status! + 1).toString()}.png',
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      laundry.customerName!,
                      style: Theme.of(Get.context!).textTheme.bodyMedium,
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Format.date(DateTime.parse(laundry.statusDate![0])),
                          style: Theme.of(Get.context!).textTheme.bodySmall,
                        ),
                        Text(
                          Format.time(DateTime.parse(laundry.statusDate![0])),
                          style: Theme.of(Get.context!).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
