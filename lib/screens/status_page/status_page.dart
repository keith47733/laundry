import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/models/sources/source_laundry.dart';

import '../../models/laundry.dart';
import '../../styles/format.dart';
import '../../styles/layout.dart';
import '../../theme/app_theme.dart';
import '../../widgets/card_title.dart';

class StatusPage extends StatefulWidget {
  StatusPage({super.key, required this.laundry});
  final Laundry laundry;
  var isQueued = false;
  var isProcessing = false;
  var isDone = false;

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    widget.laundry.queueDate != null ? widget.isQueued = true : widget.isQueued = false;

    widget.laundry.startDate != null ? widget.isProcessing = true : widget.isProcessing = false;

    widget.laundry.endDate != null ? widget.isDone = true : widget.isDone = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(
            onPressed: () => _delete(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Layout.appSpacing),
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
                      cardTitle(widget.laundry.customerName!),
                      Text('[${widget.laundry.id!}]'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.laundry.weight} kg'),
                      Text(Format.currency(widget.laundry.price!)),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(Layout.appSpacing),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(Layout.appRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Layout.appSpacing),
                        child: Text(
                          widget.laundry.status!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              Layout.appSpacing / 2,
                              Layout.appSpacing / 2,
                              Layout.appSpacing / 2,
                              0,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: const ElevatedButton(
                                    onPressed: null,
                                    child: Text('Queued'),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: ElevatedButton(
                                    onPressed:
                                        widget.laundry.status! == 'Queued' ? () => _updateStatus('Washing') : null,
                                    child: const Text('Start Washing'),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: ElevatedButton(
                                    onPressed:
                                        widget.laundry.status! == 'Washing' ? () => _updateStatus('Drying') : null,
                                    child: const Text('Start Drying'),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: ElevatedButton(
                                    onPressed:
                                        widget.laundry.status! == 'Drying' ? () => _updateStatus('Being Folded') : null,
                                    child: const Text('Start Folding'),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: ElevatedButton(
                                    onPressed:
                                        widget.laundry.status! == 'Being Folded' ? () => _updateStatus('Done') : null,
                                    child: const Text('Completed'),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: ElevatedButton(
                                    onPressed: widget.laundry.status! == 'Done' ? () => _updateStatus('Taken') : null,
                                    child: const Text('Picked up By Customer'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              Layout.appSpacing / 2,
                              Layout.appSpacing / 2,
                              Layout.appSpacing / 2,
                              0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.isQueued
                                    ? Container(
                                        width: constraints.maxWidth,
                                        margin: const EdgeInsets.only(bottom: Layout.appSpacing),
                                        decoration: BoxDecoration(
                                          color: color2,
                                          borderRadius: BorderRadius.circular(Layout.appRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Layout.appSpacing),
                                          child: Column(
                                            children: [
                                              const Text('Queued'),
                                              Text(Format.date(widget.laundry.queueDate!)),
                                              Text(Format.time(widget.laundry.queueDate!)),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(height: 10),
                                widget.isProcessing
                                    ? Container(
                                        width: constraints.maxWidth,
                                        margin: const EdgeInsets.only(bottom: Layout.appSpacing),
                                        decoration: BoxDecoration(
                                          color: color2,
                                          borderRadius: BorderRadius.circular(Layout.appRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Layout.appSpacing),
                                          child: Column(
                                            children: [
                                              const Text('Processing'),
                                              Text(Format.date(widget.laundry.startDate!)),
                                              Text(Format.time(widget.laundry.startDate!)),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(height: 10),
                                widget.isDone
                                    ? Container(
                                        width: constraints.maxWidth,
                                        decoration: BoxDecoration(
                                          color: color2,
                                          borderRadius: BorderRadius.circular(Layout.appRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Layout.appSpacing),
                                          child: Column(
                                            children: [
                                              const Text('Completed'),
                                              Text(Format.date(widget.laundry.endDate!)),
                                              Text(Format.time(widget.laundry.endDate!)),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _updateStatus(String newStatus) async {
    bool success = await SourceLaundry.updateStatus(widget.laundry.id!, newStatus);
    if (success) {
      DInfo.dialogSuccess('Successfully updated status');
      DInfo.closeDialog(
        actionAfterClose: () {
          // Get.back(result: true);
          setState(
            () {
              widget.laundry.status = newStatus;
              if (newStatus == 'Washing') {
                widget.laundry.startDate = DateTime.now();
              }
              if (newStatus == 'Done') {
                widget.laundry.endDate = DateTime.now();
              }
            },
          );
        },
      );
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
        DInfo.dialogSuccess('Successfully deleted laundry order');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Failed to delete laundry order');
        DInfo.closeDialog();
      }
    }
  }
}
