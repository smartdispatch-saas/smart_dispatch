import 'package:flutter/material.dart';

class DeliveriesScreen extends StatefulWidget {
  @override
  _DeliveriesScreenState createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {
  List<Map<String, String>> deliveries = [
    {"id": "ORD-001", "client": "Amine"},
    {"id": "ORD-002", "client": "Sara"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deliveries CRUD")),
      body: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(deliveries[index]["id"]!),
            subtitle: Text("Client: ${deliveries[index]["client"]}"),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => setState(() => deliveries.removeAt(index)),
            ),
          );
        },
      ),
    );
  }
}