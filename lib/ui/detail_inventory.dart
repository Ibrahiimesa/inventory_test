import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rds_test/data/model/response/inventory_response.dart';
import 'package:rds_test/provider/detail_inventory_provider.dart';
import 'package:rds_test/ui/add_inventory.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class DetailInventoryScreen extends StatefulWidget {
  static const routeName = '/detailInventory';
  final InventoryData inventory;

  const DetailInventoryScreen({Key? key, required this.inventory})
      : super(key: key);

  @override
  State<DetailInventoryScreen> createState() => _DetailInventoryScreenState();
}

class _DetailInventoryScreenState extends State<DetailInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailInventoryProvider>(
      create: (_) => DetailInventoryProvider(
        apiService: ApiService(http.Client()),
        id: widget.inventory.id,
      )..fetchDetailInventory(widget.inventory.id),
      child: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Inventory"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final inventoryRequest = widget.inventory.toInventoryRequest();
          Navigator.pushNamed(
            context,
            AddInventory.routeName,
            arguments: inventoryRequest,
          );
        },
        child: const Icon(
          Icons.edit,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Consumer<DetailInventoryProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.hasData) {
            final inventory = provider.result;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Product Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            _buildInfoRow("SKU:", inventory.sku),
                            _buildInfoRow("Name:", inventory.name),
                            _buildInfoRow("Cost Price:",
                                inventory.costPrice.toStringAsFixed(2)),
                            _buildInfoRow("Retail Price:",
                                inventory.retailPrice.toStringAsFixed(2)),
                            _buildInfoRow(
                                "Quantity:", inventory.qty.toString()),
                            _buildInfoRow("Margin Percentage:",
                                "${inventory.marginPercentage}%"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "Supplier Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildInfoRow(
                                "Supplier Name:", inventory.supplier.name),
                            _buildInfoRow(
                              "Address:",
                              inventory.supplier.address,
                            ),
                            _buildInfoRow(
                              "City:",
                              inventory.supplier.city,
                            ),
                            _buildInfoRow(
                              "Postal Code:",
                              inventory.supplier.postCode,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text("Contacts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    if (inventory.supplier.contacts.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: inventory.supplier.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = inventory.supplier.contacts[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              leading: Icon(
                                contact.contactType.name == "email"
                                    ? Icons.email
                                    : (contact.contactType.name == "mobilePhone"
                                        ? Icons.phone
                                        : Icons.business),
                              ),
                              title: Text(contact.contactType.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Value: ${contact.value.isNotEmpty ? contact.value : 'Not Available'}"),
                                  Text("Actor: ${contact.actor}"),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    else
                      const Text(
                        "No contacts available",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            );
          } else if (provider.state == ResultState.error) {
            return Center(
              child: Text("Error: ${provider.message}"),
            );
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
