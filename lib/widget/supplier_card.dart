import 'package:flutter/material.dart';

import '../data/model/response/supplier_response.dart';
import '../ui/add_supplier.dart';

class SupplierCard extends StatefulWidget {
  final SupplierData supplierData;

  const SupplierCard({required this.supplierData, Key? key}) : super(key: key);

  @override
  _SupplierCardState createState() => _SupplierCardState();
}

class _SupplierCardState extends State<SupplierCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final supplierData = widget.supplierData;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AddSupplier.routeName,
          arguments: supplierData,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplierData.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${supplierData.address}, ${supplierData.city}, ${supplierData.postCode}',
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ],
              ),
              if (_isExpanded)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: supplierData.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = supplierData.contacts[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2.0),
                      child: ListTile(
                        leading: Icon(
                          contact.contactType.name == "email"
                              ? Icons.email
                              : (contact.contactType.name == "mobilePhone"
                                  ? Icons.phone
                                  : Icons.business),
                          size: 20.0,
                        ),
                        title: Text(
                          contact.name.isNotEmpty
                              ? contact.name
                              : 'Unnamed Contact',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type: ${contact.contactType.name}",
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            Text(
                              "Value: ${contact.value.isNotEmpty ? contact.value : 'Not Available'}",
                              style: const TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
