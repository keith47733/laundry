import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/models/sources/source_laundry.dart';

import '../../models/laundry.dart';
import '../../styles/format.dart';
import '../../styles/layout.dart';
import '../../theme/app_theme.dart';

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
          padding: const EdgeInsets.fromLTRB(
            Layout.appSpacing,
            Layout.appSpacing,
            Layout.appSpacing,
            Layout.appSpacing,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Layout.appSpacing,
                Layout.appSpacing,
                Layout.appSpacing,
                Layout.appSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      Layout.appSpacing / 2,
                    ),
                    child: Text(
                      widget.laundry.customerName!,
                      style: Theme.of(Get.context!).textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      Layout.appSpacing,
                    ),
                    child: Text(
                      '[${widget.laundry.id!}]',
                      style: Theme.of(Get.context!).textTheme.bodySmall,
                      textScaleFactor: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      Layout.appSpacing / 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.laundry.weight} kg', style: Theme.of(context).textTheme.bodyMedium),
                        Text(Format.currency(widget.laundry.price!), style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      Layout.appSpacing / 2,
                      0,
                      Layout.appSpacing / 2,
                    ),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      Layout.appSpacing / 2,
                      0,
                      Layout.appSpacing / 4,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(Layout.appRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Layout.appSpacing),
                        child: Text(
                          widget.laundry.status!,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: lighten(color1, 80)),
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
                              0,
                              0,
                              0,
                              0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey[300],
                                      ),
                                      onPressed: null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                        child: Text('Queue', style: Theme.of(context).textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey[300],
                                      ),
                                      onPressed: widget.laundry.status! == 'Queue' ? () => _updateStatus('Wash') : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                        child: Text('Wash', style: Theme.of(context).textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey[300],
                                      ),
                                      onPressed: widget.laundry.status! == 'Wash' ? () => _updateStatus('Dry') : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                        child: Text('Dry', style: Theme.of(context).textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey[300],
                                      ),
                                      onPressed: widget.laundry.status! == 'Dry' ? () => _updateStatus('Fold') : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                        child: Text('Fold', style: Theme.of(context).textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey[300],
                                      ),
                                      onPressed: widget.laundry.status! == 'Fold' ? () => _updateStatus('Done') : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                        child: Text('Done', style: Theme.of(context).textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                  child: SizedBox(
                                    width: constraints.maxWidth,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: Colors.grey[300],
                                      ),
                                      onPressed:
                                          widget.laundry.status! == 'Done' ? () => _updateStatus('Delivered') : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(Layout.appSpacing / 2),
                                        child: Text('Delivered', style: Theme.of(context).textTheme.bodyMedium),
                                      ),
                                    ),
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
                                          color: lighten(Colors.green, 30),
                                          borderRadius: BorderRadius.circular(Layout.appRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Layout.appSpacing),
                                          child: Column(
                                            children: [
                                              Text('Queued', style: Theme.of(context).textTheme.bodyMedium),
                                              Text(Format.date(widget.laundry.queueDate!),
                                                  style: Theme.of(context).textTheme.bodySmall),
                                              Text(Format.time(widget.laundry.queueDate!),
                                                  style: Theme.of(context).textTheme.bodySmall),
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
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(Layout.appRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Layout.appSpacing),
                                          child: Column(
                                            children: [
                                              Text('Processing', style: Theme.of(context).textTheme.bodyMedium),
                                              Text(Format.date(widget.laundry.startDate!),
                                                  style: Theme.of(context).textTheme.bodySmall),
                                              Text(Format.time(widget.laundry.startDate!),
                                                  style: Theme.of(context).textTheme.bodySmall),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(height: 10),
                                widget.isDone
                                    ? Container(
                                        width: constraints.maxWidth,
                                        decoration: BoxDecoration(
                                          color: darken(Colors.green, 30),
                                          borderRadius: BorderRadius.circular(Layout.appRadius),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Layout.appSpacing),
                                          child: Column(
                                            children: [
                                              Text('Completed', style: Theme.of(context).textTheme.bodyMedium),
                                              Text(Format.date(widget.laundry.endDate!),
                                                  style: Theme.of(context).textTheme.bodySmall),
                                              Text(Format.time(widget.laundry.endDate!),
                                                  style: Theme.of(context).textTheme.bodySmall),
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
              if (newStatus == 'Wash') {
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
