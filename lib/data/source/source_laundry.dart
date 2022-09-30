import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../config/status.dart';
import '../model/laundry.dart';

class SourceLaundry {
  static final _dbRef = FirebaseFirestore.instance.collection('Laundry');

  static Future<Map<String, int>> getAnalys() async {
    Map<String, int> data = {
      'Today': 0,
      'Queue': 0,
      'Process': 0,
      'Done': 0,
    };

    var result = await _dbRef
        .where(
          'date',
          isEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        )
        .get();

    data['Today'] = result.size;

    for (var e in result.docs) {
      if (e.data()['status'] == Status.queue) {
        data['Queue'] = data['Queue']! + 1;
        continue;
      }
      if (e.data()['status'] == Status.washing ||
          e.data()['status'] == Status.beingDry ||
          e.data()['status'] == Status.beingPrepared) {
        data['Process'] = data['Process']! + 1;
        continue;
      }
      if (e.data()['status'] == Status.done) {
        data['Done'] = data['Done']! + 1;
        continue;
      }
      
    }
		return data;
  }

	static Future<Laundry?> searchById(String id) async {
		final result = await _dbRef.doc(id).get();
		if (result.exists) return Laundry.fromJson(result.data()!);
		return null;
	}

	static Future<bool> add(Laundry laundry) async {
		final result = await _dbRef.add(laundry.toJson());
		var newLaundry = await searchById(result.id);
		if (newLaundry != null) {
			result.update({'id': result.id});
			return true;
		}
		return false;
	}
}
