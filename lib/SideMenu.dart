import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket1_h1d023053/services/api_services.dart';
import '../pages/items_list_page.dart';
import '../pages/register_page.dart';

class SideMenu extends StatelessWidget {
  final String token;
  const SideMenu({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFE8D6),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFFA9500)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          // === LIST ITEM ===
          ListTile(
            title: const Text("List Item"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsListPage(token: token),
                ),
              );
            },
          ),

          // === REGISTER PAGE ===
          ListTile(
            title: const Text("Register"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
          ),

          // === LOGOUT ===
          ListTile(
            title: const Text("Logout"),
            onTap: () async {
              final success = await ApiService().logout(token);

              if (success) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Logout gagal")));
              }
            },
          ),
        ],
      ),
    );
  }
}
