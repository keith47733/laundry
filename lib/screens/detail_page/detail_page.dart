import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/models/sources/source_laundry.dart';
import 'package:laundry/widgets/detail_laundry.dart';

import '../../models/process.dart';
import '../../models/laundry.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.laundry});
  final Laundry laundry;

  updateStatus() async {
    final updateController = TextEditingController(text: laundry.status);
    var result = await Get.dialog(
      AlertDialog(
        title: const Text('Update Status'),
        content: DropdownButtonFormField<String>(
          value: updateController.text,
          items: Process.listMenu.map((e) {
            return DropdownMenuItem<String>(value: e, child: Text(e));
          }).toList(),
          onChanged: (value) {
            updateController.text = value ?? '';
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
    if ((result ?? false) && updateController.text != '') {
      bool success = await SourceLaundry.updateStatus(laundry.id!, updateController.text);
      if (success) {
        DInfo.dialogSuccess('Successfully updated status');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Failed to update status');
        DInfo.closeDialog();
      }
    }
  }

  delete() async {
    bool? yes = await DInfo.dialogConfirmation(
      Get.context!,
      'Delete',
      'Yes to confirm',
    );
    if (yes == true) {
      bool success = await SourceLaundry.delete(laundry.id!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laundry'),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () => updateStatus(),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => delete(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: DetailLaundry(laundry: laundry),
    );
  }
}
