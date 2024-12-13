import 'package:flutter/material.dart';
import 'package:rds_test/data/model/response/inventory_response.dart';
import 'package:rds_test/ui/detail_inventory.dart';

class InventoryCard extends StatelessWidget {
  final InventoryData inventoryData;

  const InventoryCard({Key? key, required this.inventoryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailInventoryScreen.routeName,
          arguments: inventoryData,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inventoryData.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('SKU: ${inventoryData.sku}'),
              Text('Quantity: ${inventoryData.qty}'),
              Text('Cost Price: ${inventoryData.costPrice.toStringAsFixed(2)}'),
              Text(
                  'Retail Price: ${inventoryData.retailPrice.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text(
                'Supplier: ${inventoryData.supplier?.name ?? 'No supplier name available'}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text('Address: ${inventoryData.supplier?.address ?? 'No address'}, ${inventoryData.supplier?.city ?? 'No city'}',),
              Text('Contact: ${inventoryData.supplier?.contacts.isNotEmpty == true ? inventoryData.supplier!.contacts.first.value : 'No contact available'}'),
            ],
          ),
        ),
      ),
    );
  }
}
