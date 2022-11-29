import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/laundry.dart';
import '../../models/process.dart';
import '../../models/sources/source_laundry.dart';
import '../../styles/format.dart';
import '../../styles/layout.dart';
import '../../styles/app_theme.dart';

class StatusPage extends StatefulWidget {
  StatusPage({super.key, required this.laundry});
  final Laundry laundry;

  final totalSteps = Process.STATUS_DESC.length;

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(
            onPressed: () => _delete(),
            icon: const Icon(Icons.delete_outline_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Layout.SPACING * 2,
            horizontal: Layout.SPACING,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.laundry.customerName!.toUpperCase(),
                style: Theme.of(Get.context!).textTheme.titleMedium,
              ),
              const SizedBox(height: Layout.SPACING / 2),
              Text(
                '[${widget.laundry.id!}]',
                style: Theme.of(Get.context!).textTheme.bodySmall,
                textScaleFactor: 1.25,
              ),
              const SizedBox(height: Layout.SPACING),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.laundry.weight} kg',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(Format.currency(widget.laundry.price!),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: Layout.SPACING),
              const Divider(thickness: 2.0),
              const SizedBox(height: Layout.SPACING),
              Center(
                child: Text(
                  'Update Current Status',
                  style: Theme.of(Get.context!).textTheme.titleMedium,
                  textScaleFactor: 1.2,
                ),
              ),
              const SizedBox(height: Layout.SPACING / 2),
              ListView.builder(
                itemCount: Process.STATUS_DESC.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Color tileColour;
                  Color textColour;
                  if (index < widget.laundry.status!) {
                    tileColour = Colors.grey.withOpacity(0.3);
                    textColour = Colors.grey;
                  } else if (index == widget.laundry.status!) {
                    tileColour = lighten(Colors.deepOrange, 50);
                    textColour = Colors.black;
                  } else if (index == widget.laundry.status! + 1) {
                    tileColour = lighten(Colors.lightGreen, 50);
                    textColour = Colors.black;
                  } else {
                    tileColour = lighten(color2, 45);
                    textColour = Colors.black;
                  }
                  bool isComplete = index <= widget.laundry.status!;
                  return Padding(
                    padding: const EdgeInsets.only(top: Layout.SPACING),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: Layout.SPACING / 2,
                        horizontal: Layout.SPACING,
                      ),
                      dense: true,
                      tileColor: tileColour,
                      onTap: isComplete ? null : () => _updateStatus(index),
                      leading: Image.asset(
                        './assets/icons/laundry${(index + 1).toString()}.png',
                        fit: BoxFit.cover,
                        color: tileColour,
                        colorBlendMode: BlendMode.dstIn,
                      ),
                      title: Text(
                        Process.STATUS_DESC[index],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: textColour),
                      ),
                      trailing: isComplete
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Format.month(DateTime.parse(
                                      widget.laundry.statusDate![index])),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: textColour),
                                ),
                                Text(
                                  Format.time(DateTime.parse(
                                      widget.laundry.statusDate![index])),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: textColour),
                                ),
                              ],
                            )
                          : Text(
                              'UPDATE',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: textColour),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateStatus(int newStatus) async {
    if (newStatus <= widget.laundry.status!) {
      return;
    }
    List<String>? newStatusDates = [];
    for (int i = 0; i < 6; i++) {
      if (i < newStatus) {
        if (widget.laundry.statusDate![i] == '') {
          newStatusDates.add(DateTime.now().toIso8601String());
        } else {
          newStatusDates.add(widget.laundry.statusDate![i]);
        }
      } else if (i == newStatus) {
        newStatusDates.add(DateTime.now().toIso8601String());
      } else {
        newStatusDates.add('');
      }
    }
    bool success = await SourceLaundry.updateStatus(
        widget.laundry.id!, newStatus, newStatusDates);
    if (success) {
      widget.laundry.status = newStatus;
      widget.laundry.statusDate = newStatusDates;
      setState(() {});
    } else {
      DInfo.dialogError('Failed to update status');
      DInfo.closeDialog();
    }
  }

  _delete() async {
    bool? yes = await DInfo.dialogConfirmation(
      Get.context!,
      'Delete',
      'Yes to confirm',
    );
    if (yes == true) {
      bool success = await SourceLaundry.delete(widget.laundry.id!);
      if (success) {
        DInfo.dialogSuccess('Deleted order');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Failed to delete order');
        DInfo.closeDialog();
      }
    }
  }
}
