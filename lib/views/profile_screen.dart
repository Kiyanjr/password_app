import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: Column(
              children: [
                CircleAvatar(radius: 40, backgroundColor: Colors.blue, child: Text('AJ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                SizedBox(height: 12),
                Text('Alex Johnson', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text('alex@gmail.com', style: TextStyle(color: Colors.white60, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildTile(Icons.person_outline, 'Account Settings', 'Manage your account'),
          _buildTile(Icons.security, 'Security', 'Password, biometrics, 2FA'),
          _buildTile(Icons.cloud_sync, 'Backup & Restore', 'Sync your data'),
          _buildTile(Icons.help_outline, 'Help & Support', 'Get help or contact us'),
          _buildTile(Icons.info_outline, 'About', 'App version 1.0.0'),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 13)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
      onTap: () {},
    );
  }
}
