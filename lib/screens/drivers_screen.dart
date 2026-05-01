import 'package:flutter/material.dart';

class DriversScreen extends StatefulWidget {
  @override
  _DriversScreenState createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {

  List<Map<String, String>> drivers = [
    {"name": "Ahmed Mohamed", "status": "Disponible"},
    {"name": "Sara Amin", "status": "En route"},
    {"name": "Yassine Ali", "status": "Hors ligne"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Chauffeurs"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
                backgroundColor: Colors.blue.shade100,
              ),
              title: Text(drivers[index]["name"]!),
              subtitle: Text("Statut: ${drivers[index]["status"]}"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {

              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
        tooltip: "Ajouter un chauffeur",
      ),
    );
  }
}