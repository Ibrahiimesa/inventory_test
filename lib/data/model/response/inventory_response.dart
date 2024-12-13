import 'package:rds_test/data/model/response/supplier_response.dart';

import '../request/inventory_request.dart';

class InventoryResponse {
  int totalDatas;
  int totalPages;
  int page;
  List<InventoryData> data;

  InventoryResponse({
    required this.totalDatas,
    required this.totalPages,
    required this.page,
    required this.data,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      InventoryResponse(
        totalDatas: json["totalDatas"],
        totalPages: json["totalPages"],
        page: json["page"],
        data: List<InventoryData>.from(
            json["data"].map((x) => InventoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalDatas": totalDatas,
        "totalPages": totalPages,
        "page": page,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class InventoryData {
  String id;
  String sku;
  String name;
  double costPrice;
  double retailPrice;
  int qty;
  double marginPercentage;
  SupplierData? supplier;
  String actor;
  DateTime timestamp;

  InventoryData({
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

  factory InventoryData.fromJson(Map<String, dynamic> json) => InventoryData(
        id: json["id"] ?? 0,
        sku: json["sku"] ?? '',
        name: json["name"] ?? '',
        costPrice: json["costPrice"] ?? 0.0,
        retailPrice: json["retailPrice"] ?? 0.0,
        qty: json["qty"] ?? 0,
        marginPercentage: json["marginPercentage"] ?? 0.0,
        supplier: json["supplier"] != null
            ? SupplierData.fromJson(json["supplier"])
            : null,
        actor: json["actor"] ?? '',
        timestamp: DateTime.parse(json["timestamp"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "costPrice": costPrice,
        "retailPrice": retailPrice,
        "qty": qty,
        "marginPercentage": marginPercentage,
        "supplier": supplier?.toJson(),
        "actor": actor,
        "timestamp": timestamp.toIso8601String(),
      };

  InventoryRequest toInventoryRequest() {
    return InventoryRequest(
      id: id,
      isDeleted: false,
      sku: sku,
      name: name,
      costPrice: costPrice,
      retailPrice: retailPrice,
      qty: qty,
      marginPercentage: marginPercentage,
      supplierId: supplier?.id ?? 0,
    );
  }
}
