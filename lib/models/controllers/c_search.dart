import 'package:get/get.dart';

import '../laundry.dart';

class CSearch extends GetxController {
  final _data = Laundry().obs;
  Laundry get data => _data.value;
  set data(newData) {
    _data.value = newData;
  }
}
