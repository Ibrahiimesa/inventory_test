import '../response/supplier_response.dart';

class SupplierDataRequest {
  int id;
  String name;
  String address;
  String city;
  String postCode;
  List<Contact> contacts;

  SupplierDataRequest({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.postCode,
    required this.contacts,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "postCode": postCode,
        "contacts": contacts.map((x) => x.toJson()).toList(),
      };
}
