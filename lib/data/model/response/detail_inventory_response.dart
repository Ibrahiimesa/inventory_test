import 'package:rds_test/data/model/response/supplier_response.dart';

class DetailInventoryResponse {
  String id;
  String sku;
  String name;
  double costPrice;
  double retailPrice;
  int qty;
  double marginPercentage;
  SupplierData supplier;
  String actor;
  DateTime timestamp;

  DetailInventoryResponse({
    required this.id,
    required this.sku,
    required this.name,
    required this.costPrice,
    required this.retailPrice,
    required this.qty,
    required this.marginPercentage,
    required this.supplier,
    required this.actor,
    required this.timestamp,
  });

  factory DetailInventoryResponse.fromJson(Map<String, dynamic> json) =>
      DetailInventoryResponse(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        costPrice: json["costPrice"],
        retailPrice: json["retailPrice"],
        qty: json["qty"],
        marginPercentage: json["marginPercentage"],
        supplier: SupplierData.fromJson(json["supplier"]),
        actor: json["actor"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "costPrice": costPrice,
        "retailPrice": retailPrice,
        "qty": qty,
        "marginPercentage": marginPercentage,
        "supplier": supplier.toJson(),
        "actor": actor,
        "timestamp": timestamp.toIso8601String(),
      };
}
