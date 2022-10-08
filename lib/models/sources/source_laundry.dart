import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../process.dart';
import '../laundry.dart';

class SourceLaundry {
  static final _dbRef = FirebaseFirestore.instance.collection('Laundry');

  static Future<Map<String, int>> homepageSummary() async {
    Map<String, int> data = {
      'Today': 0,
      'Queued': 0,
      'Processing': 0,
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
      if (e.data()['status'] == Process.queue) {
        data['Queued'] = data['Queued']! + 1;
        continue;
      }
      if (e.data()['status'] == Process.wash ||
          e.data()['status'] == Process.dry ||
          e.data()['status'] == Process.fold) {
        data['Processing'] = data['Processing']! + 1;
        continue;
      }
      if (e.data()['status'] == Process.done ||
			    e.data()['status'] == Process.delivered) {
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

  static Future<List<Laundry>> whereStatus(String status) async {
    final result = await _dbRef.where('status', isEqualTo: status).get();
    return result.docs.map((e) => Laundry.fromJson(e.data())).toList();
  }

  static Future<bool> updateStatus(String id, String newStatus) async {
    await _dbRef.doc(id).update({'status': newStatus});
    if (newStatus == Process.wash) {
      await _dbRef.doc(id).update({'start_date': DateTime.now().microsecondsSinceEpoch});
    }
    if (newStatus == Process.done) {
      await _dbRef.doc(id).update({'end_date': DateTime.now().microsecondsSinceEpoch});
    }
    Laundry? newLaundry = await searchById(id);
    // Washing == Washing ? success : false
    return newLaundry!.status == newStatus;
  }

  static Future<bool> delete(String id) async {
    await _dbRef.doc(id).delete();
    Laundry? newLaundry = await searchById(id);
    return newLaundry == null;
  }
}
