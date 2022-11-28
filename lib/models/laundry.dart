// To parse this JSON data, do
//
//     final laundry = userFromJson(jsonString);

// import 'dart:convert';

// Laundry laundryFromJson(String str) => Laundry.fromJson(json.decode(str));

// String laundryToJson(Laundry data) => json.encode(data.toJson());

class Laundry {
  String? id;
  String? customerName;
  double? weight;
  double? price;
  String? created;
  int? status;
  List<String>? statusDate;

  Laundry({
    this.id,
    this.customerName,
    this.weight,
    this.price,
    this.created,
    this.status,
    this.statusDate,
  });

  factory Laundry.fromJson(json) => Laundry(
        id: json['id'],
        customerName: json['customer_name'],
        weight: json['weight'].toDouble(),
        price: json['price'].toDouble(),
        created: json['created'],
        status: json['status'],
        statusDate:
            (json['status_date'] as Iterable).map((e) => e.toString()).toList(),
      );

  toJson() => {
        'id': id,
        'customer_name': customerName,
        'weight': weight,
        'price': price,
        'created': created,
        'status': status,
        'status_date': statusDate,
      };
}
