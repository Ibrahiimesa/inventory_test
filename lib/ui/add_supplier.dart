import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rds_test/data/model/request/supplier_request.dart';
import 'package:rds_test/widget/contact_card.dart';

import '../data/model/response/supplier_response.dart';
import '../provider/add_supplier_provider.dart';

class AddSupplier extends StatefulWidget {
  static const routeName = '/add';
  final SupplierData? supplierData;

  const AddSupplier({super.key, this.supplierData});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    if (widget.supplierData != null) {
      final supplier = widget.supplierData!;
      nameController.text = supplier.name;
      addressController.text = supplier.address;
      cityController.text = supplier.city;
      postCodeController.text = supplier.postCode;
      contacts = List.from(supplier.contacts);
    }
  }

  void addContactField() {
    setState(() {
      contacts.add(
          Contact(name: "", contactType: ContactType.mobilePhone, value: ""));
    });
  }

  void removeContactField(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void submitForm(AddSupplierProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final supplierData = SupplierDataRequest(
        id: widget.supplierData?.id ?? 0,
        name: nameController.text,
        address: addressController.text,
        city: cityController.text,
        postCode: postCodeController.text,
        contacts: contacts,
      );

      try {
        String message;
        if (widget.supplierData == null) {
          message = await provider.addSupplier(supplierData);
        } else {
          message = await provider.updateSupplier(supplierData);
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
    final addSupplierProvider = Provider.of<AddSupplierProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.supplierData != null ? 'Edit Supplier' : 'Add Supplier'),
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
                      controller: addressController,
                      decoration: const InputDecoration(labelText: "Address"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an address";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(labelText: "City"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a city";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: postCodeController,
                      decoration: const InputDecoration(labelText: "Post Code"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a post code";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Contacts",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(
                          onPressed: addContactField,
                          icon: const Icon(Icons.add),
                          tooltip: "Add Contact",
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return ContactCard(
                          index: index,
                          contact: contacts[index],
                          onNameChanged: (value) {
                            setState(() {
                              contacts[index].name = value;
                            });
                          },
                          onTypeChanged: (type) {
                            setState(() {
                              contacts[index].contactType = type!;
                            });
                          },
                          onValueChanged: (value) {
                            setState(() {
                              contacts[index].value = value;
                            });
                          },
                          onRemove: () {
                            setState(() {
                              contacts.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      // Aligns the button to the right
                      child: ElevatedButton(
                        onPressed: () => submitForm(addSupplierProvider),
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
                          widget.supplierData == null
                              ? "Add Supplier"
                              : "Edit Supplier",
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
