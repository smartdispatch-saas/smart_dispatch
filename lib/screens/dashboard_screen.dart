import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: const Color(0xFF263238),
            child: Column(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Icon(Icons.admin_panel_settings, color: Colors.white, size: 50),
                  ),
                ),
                _menuItem(Icons.dashboard, "Tableau de bord"),
                _menuItem(Icons.people, "Livreurs"),
                _menuItem(Icons.shopping_cart, "Commandes"),
                const Spacer(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white70),
                  title: const Text("Déconnexion", style: TextStyle(color: Colors.white70)),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Bienvenue dans votre espace de gestion",
                style: TextStyle(fontSize: 22, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      onTap: () {},
    );
  }
}