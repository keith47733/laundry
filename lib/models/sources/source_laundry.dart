import 'package:cloud_firestore/cloud_firestore.dart';

import '../laundry.dart';

class SourceLaundry {
  static final _dbRef = FirebaseFirestore.instance.collection('Laundry');

  static Future<Map<String, int>> homePageSummary() async {
    Map<String, int> orderSummary = {
      'Today': 0,
      'Queued': 0,
      'Processing': 0,
      'Complete': 0,
    };
    var ordersToday = await _dbRef
        // .where('created', isEqualTo: Format.date(DateTime.now()))
        .get();
    orderSummary['Today'] = ordersToday.size;
    for (var e in ordersToday.docs) {
      if (e.data()['status'] == 0) {
        orderSummary['Queued'] = orderSummary['Queued']! + 1;
      }
      if (e.data()['status'] == 1 ||
          e.data()['status'] == 2 ||
          e.data()['status'] == 3) {
        orderSummary['Processing'] = orderSummary['Processing']! + 1;
      }
      if (e.data()['status'] == 4 || e.data()['status'] == 5) {
        orderSummary['Complete'] = orderSummary['Complete']! + 1;
      }
    }
    return orderSummary;
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

  static Future<List<Laundry>> whereStatus(int status) async {
    final result = await _dbRef.where('status', isEqualTo: status).get();
    return result.docs.map((e) => Laundry.fromJson(e.data())).toList();
  }

  static Future<bool> updateStatus(id, newStatus, newStatusDates) async {
    await _dbRef.doc(id).update({'status': newStatus});
    await _dbRef.doc(id).update(
      {'status_date': newStatusDates},
    );
    return true;
  }

  static Future<bool> delete(String id) async {
    await _dbRef.doc(id).delete();
    Laundry? newLaundry = await searchById(id);
    return newLaundry == null;
  }
}
