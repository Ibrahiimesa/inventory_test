import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rds_test/data/model/request/inventory_request.dart';
import 'package:rds_test/data/model/request/supplier_request.dart';
import 'package:rds_test/data/model/response/detail_inventory_response.dart';
import 'package:rds_test/data/model/response/inventory_response.dart';

import '../model/response/supplier_response.dart';

class ApiService {
  final http.Client client;

  ApiService(this.client);

  static const String baseUrl =
      'https://mobile.dev.quadrant-si.id/developertest';
  static const String token = '';

  Future<SupplierResponse> getSupplier(int page, int size) async {
    final response = await client.get(
      Uri.parse('$baseUrl/supplier/inquiry/$page/$size'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return SupplierResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to supplier');
    }
  }

  Future<String> addSupplier(SupplierDataRequest supplier) async {
    final response = await client.post(
      Uri.parse('$baseUrl/supplier/'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(supplier.toJson()),
    );
    if (response.statusCode == 200) {
      return 'Supplier added successfully';
    } else {
      throw Exception('Failed to add supplier');
    }
  }

  Future<String> updateSupplier(SupplierDataRequest supplier) async {
    final response = await client.put(
      Uri.parse('$baseUrl/supplier/'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(supplier.toJson()),
    );
    if (response.statusCode == 200) {
      return 'Supplier updated successfully';
    } else {
      throw Exception('Failed to update supplier');
    }
  }

  Future<InventoryResponse> getInventory(int page, int size) async {
    final response = await client.get(
      Uri.parse('$baseUrl/inventoryitem/inquiry/$page/$size'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return InventoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get inventory');
    }
  }

  Future<DetailInventoryResponse> getDetailInventory(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/inventoryitem/$id'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return DetailInventoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get detail inventory');
    }
  }

  Future<String> addInventory(InventoryRequest inventory) async {
    final response = await client.post(
      Uri.parse('$baseUrl/InventoryItem/'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(inventory.toJson()),
    );
    if (response.statusCode == 200) {
      return 'Inventory added successfully';
    } else {
      throw Exception('Failed to add inventory');
    }
  }

  Future<String> updateInventory(InventoryRequest inventory) async {
    final response = await client.put(
      Uri.parse('$baseUrl/InventoryItem/UpdateItem'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(inventory.toJson()),
    );
    if (response.statusCode == 200) {
      return 'Inventory updated successfully';
    } else {
      throw Exception('Failed to update inventory');
    }
  }
}
