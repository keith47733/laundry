import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../models/laundry.dart';

class DetailLaundry extends StatelessWidget {
  const DetailLaundry({super.key, required this.laundry});
  final Laundry laundry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        dataText('Customer', laundry.customerName!),
        dataText('Status', laundry.status!),
        dataText('Queue Date', Style.date(laundry.queueDate!)),
        dataText('Queue Time', Style.time(laundry.queueDate!)),
        dataText('Weight', '${laundry.weight} kg'),
        dataText('Price', Style.currency(laundry.price!)),
        DView.spaceHeight(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (laundry.startDate != null)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('Washing (Start)'),
              ),
            if (laundry.endDate != null)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('Done (End)'),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (laundry.startDate != null)
              Text(
                '${Style.date(laundry.startDate!)}\n${Style.time(laundry.startDate!)}',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (laundry.endDate != null)
              Text(
                '${Style.date(laundry.endDate!)}\n${Style.time(laundry.endDate!)}',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ],
    );
  }

  Widget dataText(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:'),
        DView.spaceHeight(4),
        Text(
          body,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        DView.spaceHeight(),
      ],
    );
  }
}
