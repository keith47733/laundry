import 'package:get/get.dart';

import '../data/model/laundry.dart';
import '../data/source/source_laundry.dart';

class CWhereStatus extends GetxController {
  final list = <Laundry>[].obs;
  setList(String status) async {
    list.value = await SourceLaundry.whereStatus(status);
    update();
  }
}
