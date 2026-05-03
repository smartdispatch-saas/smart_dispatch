import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final supabase = Supabase.instance.client;

  int totalCommandes = 0;
  int totalLivreurs = 0;
  int totalClients = 0;
  int totalLivraisons = 0;
  List<Map<String, dynamic>> dernieresCommandes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final commandes = await supabase
          .from('Commande')
          .select('*')
          .order('date_creation', ascending: false)
          .limit(5);

      final livreurs = await supabase
          .from('Livreur')
          .select('id');

      final clients = await supabase
          .from('Client')
          .select('id');

      final livraisons = await supabase
          .from('Livraison')
          .select('id');

      setState(() {
        totalCommandes = (commandes as List).length;
        totalLivreurs = (livreurs as List).length;
        totalClients = (clients as List).length;
        totalLivraisons = (livraisons as List).length;
        dernieresCommandes = List<Map<String, dynamic>>.from(commandes);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFF97316),
                    ),
                  )
                : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: const Color(0xFF111318),
      child: Column(
        children: [
          const SizedBox(height: 28),
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF97316),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.local_shipping, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                    children: [
                      TextSpan(text: 'Dis'),
                      TextSpan(text: 'patch', style: TextStyle(color: Color(0xFFF97316))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _navItem(Icons.dashboard, 'Tableau de bord', true),
          _navItem(Icons.shopping_cart, 'Commandes', false),
          _navItem(Icons.people, 'Livreurs', false),
          _navItem(Icons.person, 'Clients', false),
          _navItem(Icons.route, 'Tournées', false),
          _navItem(Icons.directions_car, 'Véhicules', false),
          const Spacer(),
          const Divider(color: Color(0xFF22262F)),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Déconnexion', style: TextStyle(color: Colors.white70)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
 Widget _navItem(IconData icon, String title, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFF97316).withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: active ? const Color(0xFFF97316) : Colors.white38, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: active ? const Color(0xFFF97316) : Colors.white54,
            fontWeight: active ? FontWeight.w700 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'Tableau de Bord',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bienvenue dans votre espace de gestion',
            style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
          ),
          const SizedBox(height: 28),

          // Stats Cards
          Row(
            children: [
              _statCard('Commandes', totalCommandes.toString(), Icons.shopping_cart, const Color(0xFFF97316)),
              const SizedBox(width: 16),
              _statCard('Livreurs', totalLivreurs.toString(), Icons.people, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _statCard('Clients', totalClients.toString(), Icons.person, const Color(0xFF22C55E)),
              const SizedBox(width: 16),
              _statCard('Livraisons', totalLivraisons.toString(), Icons.local_shipping, const Color(0xFFA855F7)),
            ],
          ),
          const SizedBox(height: 28),

          // Tableau commandes
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF111318),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF22262F)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Dernières Commandes',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                const Divider(color: Color(0xFF22262F), height: 1),
                // Table Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: const [
                      Expanded(child: Text('ID', style: TextStyle(color: Colors.white38, fontSize: 11))),
                      Expanded(flex: 2, child: Text('STATUT', style: TextStyle(color: Colors.white38, fontSize: 11))),
                      Expanded(flex: 2, child: Text('PRIORITÉ', style: TextStyle(color: Colors.white38, fontSize: 11))),
                      Expanded(flex: 2, child: Text('DATE', style: TextStyle(color: Colors.white38, fontSize: 11))),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFF22262F), height: 1),
                // Rows
                dernieresCommandes.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(20),
 child: Text('Aucune commande', style: TextStyle(color: Colors.white38)),
                      )
                    : Column(
                        children: dernieresCommandes.map((cmd) => _commandeRow(cmd)).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF111318),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF22262F)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  Widget _commandeRow(Map<String, dynamic> cmd) {
    Color statusColor = const Color(0xFF3B82F6);
    if (cmd['Statut'] == 'Livrée') statusColor = const Color(0xFF22C55E);
    if (cmd['Statut'] == 'Annulée') statusColor = const Color(0xFFEF4444);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '#${cmd['id']}',
                  style: const TextStyle(color: Color(0xFFF97316), fontSize: 13),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cmd['Statut'] ?? 'En attente',
                    style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  cmd['Priorite'] ?? '-',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  cmd['date_creation']?.toString().substring(0, 10) ?? '-',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFF22262F), height: 1),
      ],
    );
  }
}