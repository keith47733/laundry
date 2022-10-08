import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../styles/layout.dart';
import '../../models/laundry.dart';
import '../../models/sources/source_laundry.dart';
import '../../widgets/input_box.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  final controllerCustomerName = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerPrice = TextEditingController();

  addLaundryOrder() async {
    bool success = await SourceLaundry.add(
      Laundry(
        weight: double.parse(controllerWeight.text),
        price: double.parse(controllerPrice.text),
        status: 'Queue',
        queueDate: DateTime.now(),
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        customerName: controllerCustomerName.text,
      ),
    );
    if (success) {
      DInfo.dialogSuccess('Successfully added laundry order');
      DInfo.closeDialog(actionAfterClose: () {
        Get.back(result: true);
      });
    } else {
      DInfo.dialogError('Failed to add laundry order');
      DInfo.closeDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Laundry Order')),
      body: Padding(
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
            child: ListView(
							shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    Layout.appSpacing * 2,
                  ),
                  child: Text('Add Laundry Order', style: Theme.of(context).textTheme.bodyLarge),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Layout.appSpacing),
                  child: inputBox(context, 'Customer name:', 'Enter the customer name', controllerCustomerName),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Layout.appSpacing),
                  child: inputBox(context, 'Weight:', 'Enter the weight [kg]', controllerWeight),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Layout.appSpacing),
                  child: inputBox(context, 'Price:', 'Enter the price [\$]', controllerPrice),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    Layout.appSpacing,
                    0,
                    0,
                  ),
                  child: ElevatedButton(
                    onPressed: addLaundryOrder,
                    child: Padding(
                      padding: const EdgeInsets.all(Layout.appSpacing),
                      child: Text(
                        'Add Laundry Order',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
