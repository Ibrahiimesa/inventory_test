import '../response/inventory_response.dart';

class InventoryRequest {
  String id;
  bool isDeleted;
  String sku;
  String name;
  double costPrice;
  double retailPrice;
  int qty;
  double marginPercentage;
  int supplierId;

  InventoryRequest({
    required this.id,
    required this.isDeleted,
    required this.sku,
    required this.name,
    required this.costPrice,
    required this.retailPrice,
    required this.qty,
    required this.marginPercentage,
    required this.supplierId,
  });

  factory InventoryRequest.fromJson(Map<String, dynamic> json) =>
      InventoryRequest(
        id: json["id"],
        isDeleted: json["isDeleted"],
        sku: json["sku"],
        name: json["name"],
        costPrice: json["costPrice"],
        retailPrice: json["retailPrice"],
        qty: json["qty"],
        marginPercentage: json["marginPercentage"],
        supplierId: json["supplierId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDeleted": isDeleted,
        "sku": sku,
        "name": name,
        "costPrice": costPrice,
        "retailPrice": retailPrice,
        "qty": qty,
        "marginPercentage": marginPercentage,
        "supplierId": supplierId,
      };

  factory InventoryRequest.fromInventoryData(InventoryData data) {
    return InventoryRequest(
      id: data.id,
      isDeleted: false,
      sku: data.sku,
      name: data.name,
      costPrice: data.costPrice,
      retailPrice: data.retailPrice,
      qty: data.qty,
      marginPercentage: data.marginPercentage,
      supplierId: data.supplier?.id ?? 0,
    );
  }
}
