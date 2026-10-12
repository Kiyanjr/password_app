import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Security Settings',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItem(
            Icons.lock_outline,
            'Master Password',
            'Change your master password',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              secondary:
                  const Icon(Icons.fingerprint, color: Colors.blueAccent),
              title: const Text('Biometric Login',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Use fingerprint or face ID',
                  style: TextStyle(color: Colors.white60, fontSize: 13)),
              value: _biometricEnabled,
              activeColor: Colors.blue,
              onChanged: (val) => setState(() => _biometricEnabled = val),
            ),
          ),
          const SizedBox(height: 12),
          _buildItem(
            Icons.timer_outlined,
            'Auto Lock',
            'Lock the app after 5 minutes of inactivity',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildItem(
            Icons.cloud_upload_outlined,
            'Backup & Restore',
            'Backup your data to the cloud',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildItem(
            Icons.security,
            'Two-Factor Authentication',
            'Add an extra layer of security',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, String subtitle,
      {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: Colors.white60, fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 14, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }
}
