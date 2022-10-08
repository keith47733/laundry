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
      appBar: AppBar(title: Text(widget.status)),
      body: GetBuilder<CWhereStatus>(
        builder: (_) {
          if (_.list.isEmpty) {
            return const Center(
              child: Image(
                image: AssetImage('./assets/icons/no orders.png'),
                height: Layout.appSpacing * 12,
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
                  Layout.appSpacing,
                  Layout.appSpacing,
                  0,
                ),
                child: IntrinsicHeight(
									child: ListTile(
										onTap: () {
											Get.off(() => StatusPage(laundry: laundry))?.then(
												(value) {
													if (value ?? false) {
														refresh();
													}
												},
											);
										},
										leading: Image(
											image: AssetImage('./assets/icons/${laundry.status!.toLowerCase()}.png'),
											fit: BoxFit.fill,
										),
										title: Padding(
											padding: const EdgeInsets.fromLTRB(
												0,
												Layout.appSpacing / 2,
												0,
												0,
											),
											child: Text(
												laundry.customerName!,
												style: Theme.of(Get.context!).textTheme.bodyMedium,
											),
										),
										subtitle: Padding(
											padding: const EdgeInsets.fromLTRB(
												0,
												Layout.appSpacing / 4,
												0,
												Layout.appSpacing,
											),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: [
													Text(Format.date(laundry.queueDate!), style: Theme.of(Get.context!).textTheme.bodySmall),
													Text(Format.time(laundry.queueDate!), style: Theme.of(Get.context!).textTheme.bodySmall),
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
