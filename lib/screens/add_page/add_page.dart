import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/widgets/card_title.dart';

import '../../models/laundry.dart';
import '../../models/sources/source_laundry.dart';
import '../../theme/layout.dart';
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
        status: 'Queued',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add New'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          Layout.appSpacing,
          Layout.appSpacing,
          Layout.appSpacing,
          Layout.appSpacing,
        ),
        child: Card(
          elevation: Layout.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Layout.appRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Layout.appSpacing,
              0,
              Layout.appSpacing,
              Layout.appSpacing,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                cardTitle('Add Laundry Order'),
                inputBox(context, 'Customer name:', 'Enter the customer name', controllerCustomerName),
                inputBox(context, 'Weight:', 'Enter the weight [kg]', controllerWeight),
                inputBox(context, 'Price:', 'Enter the price [\$]', controllerPrice),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    Layout.appSpacing,
                    0,
                    Layout.appSpacing / 2,
                  ),
                  child: ElevatedButton(
                    onPressed: addLaundryOrder,
                    child: const Padding(
                      padding: EdgeInsets.all(Layout.appSpacing / 2),
                      child: Text(
                        'Add Laundry Order',
                        textScaleFactor: 0.75,
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
