import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/vault_viewmodel.dart';
import 'add_password_screen.dart';
import 'password_generator_screen.dart';
import 'view_password_screen.dart';
import 'profile_screen.dart';
import 'security_settings_screen.dart';

class VaultOverviewScreen extends StatefulWidget {
  const VaultOverviewScreen({super.key});

  @override
  State<VaultOverviewScreen> createState() => _VaultOverviewScreenState();
}

class _VaultOverviewScreenState extends State<VaultOverviewScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VaultViewModel>(context, listen: false).loadPasswords();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VaultViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello,', style: TextStyle(color: Colors.white60, fontSize: 13)),
            Text('Alex 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade700,
                child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your passwords are safe.', style: TextStyle(color: Colors.white60, fontSize: 13)),
            const SizedBox(height: 16),
            TextField(
              onChanged: (val) => viewModel.setSearchQuery(val),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search passwords...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Total', viewModel.totalCount.toString(), Colors.white),
                  _buildStatItem('Strong', viewModel.strongCount.toString(), Colors.greenAccent),
                  _buildStatItem('Weak', viewModel.weakCount.toString(), Colors.redAccent),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.passwords.isEmpty
                      ? const Center(child: Text('No passwords found', style: TextStyle(color: Colors.white54)))
                      : ListView.builder(
                          itemCount: viewModel.passwords.length,
                          itemBuilder: (context, index) {
                            final item = viewModel.passwords[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white10,
                                  child: Icon(_getIconForCategory(item.title), color: Colors.blueAccent),
                                ),
                                title: Text(item.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                subtitle: Text(item.username, style: const TextStyle(color: Colors.white60, fontSize: 13)),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => ViewPasswordScreen(passwordItem: item)),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPasswordScreen()),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.vpn_key), label: 'Generator'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PasswordGeneratorScreen()),
            ).then((_) => setState(() => _currentIndex = 0));
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()),
            ).then((_) => setState(() => _currentIndex = 0));
          }
        },
      ),
    );
  }

  IconData _getIconForCategory(String title) {
    switch (title.toLowerCase()) {
      case 'google': return Icons.g_mobiledata;
      case 'youtube': return Icons.play_arrow;
      case 'facebook': return Icons.facebook;
      case 'github': return Icons.code;
      default: return Icons.shield;
    }
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}
