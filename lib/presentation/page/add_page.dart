import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/model/laundry.dart';
import '../../data/source/source_laundry.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  final controllerCustomerName = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerPrice = TextEditingController();

  add() async {
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
      DInfo.dialogSuccess('Successfully added new laundry');
      DInfo.closeDialog(actionAfterClose: () {
        Get.back(result: true);
      });
    } else {
      DInfo.dialogError('Failed to add new laundry');
      DInfo.closeDialog();
    }
  }

  // String? id;
  // int? weight;
  // int? price;
  // String? status;
  // DateTime? queueDate;
  // String? date;
  // DateTime? startDate;
  // DateTime? endDate;
  // String? customerName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add New'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            controller: controllerCustomerName,
            title: 'Customer Name',
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerWeight,
            title: 'Weight',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerPrice,
            title: 'Price',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          ElevatedButton(
            onPressed: () {
              add();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
