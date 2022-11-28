import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/layout.dart';
import '../../models/laundry.dart';
import '../../models/sources/source_laundry.dart';
import '../../styles/format.dart';
import 'input_box.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  final controllerName = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerPrice = TextEditingController();

  addLaundryOrder() async {
    bool success = await SourceLaundry.add(
      Laundry(
        customerName: controllerName.text,
        weight: double.parse(controllerWeight.text),
        price: double.parse(controllerPrice.text),
        created: Format.date(DateTime.now()),
        status: 0,
        statusDate: <String>[
          DateTime.now().toIso8601String(),
          '',
          '',
          '',
          '',
          '',
        ],
      ),
    );
    if (success) {
      Get.back(result: true);
      DInfo.snackBarSuccess('Successfully added laundry order');
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
        padding: const EdgeInsets.all(Layout.SPACING),
        child: Padding(
          padding: const EdgeInsets.all(Layout.SPACING),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Text('Order Details',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: Layout.SPACING / 2),
              const Divider(thickness: 2.0),
              const SizedBox(height: Layout.SPACING),
              inputBox(
                context,
                'Customer name:',
                'Enter the customer name',
                controllerName,
                TextInputAction.next,
              ),
              const SizedBox(height: Layout.SPACING),
              inputBox(
                context,
                'Weight:',
                'Enter the weight [kg]',
                controllerWeight,
                TextInputAction.next,
              ),
              const SizedBox(height: Layout.SPACING),
              inputBox(
                context,
                'Price:',
                'Enter the price [\$]',
                controllerPrice,
                TextInputAction.done,
              ),
              const SizedBox(height: Layout.SPACING * 2),
              ElevatedButton(
                onPressed: addLaundryOrder,
                child: const Padding(
                  padding: EdgeInsets.all(Layout.SPACING),
                  child: Text('Queue Laundry Order'),
                ),
              ),
              const SizedBox(height: Layout.SPACING / 2),
            ],
          ),
        ),
      ),
    );
  }
}
