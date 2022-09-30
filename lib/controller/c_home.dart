import 'package:get/get.dart';

import '../data/source/source_laundry.dart';

class CHome extends GetxController {
  // final _data = Laundry().obs;
  // Laundry get data => _data.value;
  // set data(newData) {
  // 	_data.value	= newData;
  // }

  final _analysis = {
    'Today': 0,
    'Queue': 0,
    'Process': 0,
    'Done': 0,
  }.obs;

  Map get analysis => _analysis.value;
  setAnalysis() async {
    _analysis.value = Map.from(await SourceLaundry.getAnalys());
  }
}
