import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rds_test/data/model/request/inventory_request.dart';
import 'package:rds_test/provider/add_inventory_provider.dart';

class AddInventory extends StatefulWidget {
  static const routeName = '/addInventory';

  final InventoryRequest? inventoryRequest;

  const AddInventory({super.key, this.inventoryRequest});

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController retailPriceController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController marginPercentageController =
      TextEditingController();
  final TextEditingController supplierIdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.inventoryRequest != null) {
      final inventory = widget.inventoryRequest!;

      skuController.text = inventory.sku;
      nameController.text = inventory.name;
      costController.text = inventory.costPrice.toString();
      retailPriceController.text = inventory.retailPrice.toString();
      qtyController.text = inventory.qty.toString();
      marginPercentageController.text = inventory.marginPercentage.toString();
      supplierIdController.text = inventory.supplierId.toString();
    }
  }

  void submitForm(AddInventoryProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final inventoryData = InventoryRequest(
        id: widget.inventoryRequest?.id ?? '',
        sku: skuController.text,
        name: nameController.text,
        isDeleted: widget.inventoryRequest?.isDeleted ?? false,
        costPrice: double.tryParse(costController.text) ?? 0.0,
        retailPrice: double.tryParse(retailPriceController.text) ?? 0.0,
        qty: int.tryParse(qtyController.text) ?? 0,
        marginPercentage:
            double.tryParse(marginPercentageController.text) ?? 0.0,
        supplierId: int.tryParse(supplierIdController.text) ?? 0,
      );

      try {
        String message;
        if (widget.inventoryRequest == null) {
          message = await provider.addInventory(inventoryData);
        } else {
          message = await provider.updateInventory(inventoryData);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final addInventoryPovider = Provider.of<AddInventoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.inventoryRequest != null
            ? 'Edit Inventory'
            : 'Add Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: skuController,
                      decoration: const InputDecoration(labelText: "SKU"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter SKU";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: costController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: "Cost Price"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter cost price";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: retailPriceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration:
                          const InputDecoration(labelText: "Retail Price"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter retail price";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: qtyController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: "Qyt"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Qyt";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: marginPercentageController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration:
                          const InputDecoration(labelText: "Margin Percentage"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter margin percentage";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: supplierIdController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration:
                          const InputDecoration(labelText: "Supplier Id"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter supplier id";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => submitForm(addInventoryPovider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: Text(
                          widget.inventoryRequest == null
                              ? "Add Inventory"
                              : "Edit Inventory",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
