class SupplierResponse {
  int totalDatas;
  int totalPages;
  int page;
  List<SupplierData> data;

  SupplierResponse({
    required this.totalDatas,
    required this.totalPages,
    required this.page,
    required this.data,
  });

  factory SupplierResponse.fromJson(Map<String, dynamic> json) =>
      SupplierResponse(
        totalDatas: json["totalDatas"],
        totalPages: json["totalPages"],
        page: json["page"],
        data: List<SupplierData>.from(
            json["data"].map((x) => SupplierData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalDatas": totalDatas,
        "totalPages": totalPages,
        "page": page,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SupplierData {
  int id;
  String name;
  String address;
  String city;
  String postCode;
  List<Contact> contacts;
  String actor;
  DateTime timestamp;

  SupplierData({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.postCode,
    required this.contacts,
    required this.actor,
    required this.timestamp,
  });

  factory SupplierData.fromJson(Map<String, dynamic> json) => SupplierData(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        address: json['address'] ?? '',
        city: json['city'] ?? '',
        postCode: json['postCode'] ?? '',
        contacts: (json['contacts'] as List<dynamic>?)
                ?.map((contact) => Contact.fromJson(contact))
                .toList() ??
            [],
        actor: json["actor"] ?? '',
        timestamp: DateTime.parse(json["timestamp"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "postCode": postCode,
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        "actor": actor,
        "timestamp": timestamp.toIso8601String(),
      };
}

class Contact {
  String name;
  ContactType contactType;
  String value;
  String? actor;
  DateTime? timestamp;

  Contact({
    required this.name,
    required this.contactType,
    required this.value,
    this.actor,
    this.timestamp,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        contactType: ContactTypeExtension.fromJson(json["contactType"]),
        value: json["value"],
        actor: json["actor"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contactType": contactType.name,
        "value": value,
      };
}

enum ContactType { mobilePhone, officePhone, email }

extension ContactTypeExtension on ContactType {
  String toJson() {
    switch (this) {
      case ContactType.mobilePhone:
        return 'mobilePhone';
      case ContactType.officePhone:
        return 'officePhone';
      case ContactType.email:
        return 'email';
    }
  }

  static ContactType fromJson(String json) {
    switch (json) {
      case 'mobilePhone':
        return ContactType.mobilePhone;
      case 'officePhone':
        return ContactType.officePhone;
      case 'email':
        return ContactType.email;
      default:
        throw ArgumentError('Invalid contact type: $json');
    }
  }
}
