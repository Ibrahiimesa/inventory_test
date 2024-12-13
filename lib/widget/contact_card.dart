import 'package:flutter/material.dart';

import '../data/model/response/supplier_response.dart';

class ContactCard extends StatelessWidget {
  final int index;
  final Contact contact;
  final Function(String) onNameChanged;
  final Function(ContactType?) onTypeChanged;
  final Function(String) onValueChanged;
  final VoidCallback onRemove;

  const ContactCard({
    Key? key,
    required this.index,
    required this.contact,
    required this.onNameChanged,
    required this.onTypeChanged,
    required this.onValueChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: contact.name,
              decoration: const InputDecoration(labelText: "Contact Name"),
              onChanged: onNameChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a contact name";
                }
                return null;
              },
            ),
            DropdownButtonFormField<ContactType>(
              value: contact.contactType,
              decoration: const InputDecoration(labelText: "Contact Type"),
              items: ContactType.values.map((ContactType type) {
                return DropdownMenuItem<ContactType>(
                  value: type,
                  child: Text(type.toJson()),
                );
              }).toList(),
              onChanged: onTypeChanged,
              validator: (value) {
                if (value == null) {
                  return "Please select a contact type";
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: contact.value,
              decoration: const InputDecoration(labelText: "Contact Value"),
              onChanged: onValueChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a contact value";
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRemove,
                child: const Text(
                  "Remove Contact",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
