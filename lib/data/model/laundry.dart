// To parse this JSON data, do
//
//     final laundry = userFromJson(jsonString);

// import 'dart:convert';

// Laundry laundryFromJson(String str) => Laundry.fromJson(json.decode(str));

// String laundryToJson(Laundry data) => json.encode(data.toJson());

class Laundry {
  String? id;
  int? weight;
  int? price;
  String? status;
  DateTime? queueDate;
  String? date;
  DateTime? startDate;
  DateTime? endDate;
  String? customerName;

  Laundry({
    this.id,
    this.weight,
    this.price,
    this.status,
    this.queueDate,
    this.date,
    this.startDate,
    this.endDate,
    this.customerName,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) => Laundry(
        id: json["id"],
        weight: json["weight"].toDouble(),
        price: json["price"].toDoubel(),
        status: json["status"],
        queueDate: DateTime.fromMicrosecondsSinceEpoch(json["queue_date"]),
        date: json["date"],
        startDate: json["start_date"] == null ? null : DateTime.fromMicrosecondsSinceEpoch(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.fromMicrosecondsSinceEpoch(json["end_date"]),
        customerName: json["customer_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "price": price,
        "status": status,
        "queue_date": queueDate!.microsecondsSinceEpoch,
        "date": date,
        "start_date": startDate == null ? null : startDate!.microsecondsSinceEpoch,
        "end_date": endDate == null ? null : startDate!.microsecondsSinceEpoch,
        "customer_name": customerName,
      };
}
