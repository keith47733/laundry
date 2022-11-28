import 'package:get/get.dart';

import '../laundry.dart';
import '../sources/source_laundry.dart';

class CWhereStatus extends GetxController {
  final list = <Laundry>[].obs;
  setList(int status) async {
    list.value = await SourceLaundry.whereStatus(status);
    update();
  }
}
