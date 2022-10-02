import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/styles/style.dart';

import '../../models/controllers/c_where_status.dart';
import '../../models/laundry.dart';
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
      body: GetBuilder<CWhereStatus>(builder: (_) {
        if (_.list.isEmpty) return DView.empty();
        return ListView.builder(
          itemCount: _.list.length,
          itemBuilder: ((context, index) {
            Laundry laundry = _.list[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => DetailPage(laundry: laundry))?.then((value) {
                    if (value ?? false) {
                      refresh();
                    }
                  });
                },
                leading: CircleAvatar(
                  radius: 18,
                  child: Text('${index + 1}'),
                ),
                horizontalTitleGap: 10,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(laundry.customerName!),
                    DView.spaceWidth(8),
                    Text('(${laundry.id})', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Style.date(laundry.queueDate!)),
                    Text(Style.time(laundry.queueDate!)),
                  ],
                ),
                trailing: const Icon(Icons.navigate_next),
              ),
            );
          }),
        );
      }),
    );
  }
}
