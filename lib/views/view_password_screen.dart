import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/password_model.dart';
import '../viewmodels/vault_viewmodel.dart';
import 'edit_password_screen.dart';

class ViewPasswordScreen extends StatelessWidget {
  final PasswordModel passwordItem;
  const ViewPasswordScreen({super.key, required this.passwordItem});

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
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.g_mobiledata, color: Colors.blueAccent, size: 30)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(passwordItem.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${passwordItem.title.toLowerCase()}.com', style: const TextStyle(color: Colors.white60, fontSize: 13)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildLabel('Username / Email'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(child: Text(passwordItem.username, style: const TextStyle(color: Colors.white, fontSize: 15))),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white54, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: passwordItem.username));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username copied')));
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildLabel('Password'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(child: Text(passwordItem.password, style: const TextStyle(color: Colors.white, fontSize: 15))),
                  const Icon(Icons.visibility_off, color: Colors.white54, size: 20),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white54, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: passwordItem.password));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password copied')));
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildLabel('Password Strength'),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: 0.9, backgroundColor: Colors.white10, color: Colors.greenAccent),
            const SizedBox(height: 4),
            const Align(alignment: Alignment.centerRight, child: Text('Strong', style: TextStyle(color: Colors.greenAccent, fontSize: 12))),
            const SizedBox(height: 16),
            _buildLabel('Notes'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
              child: Text(passwordItem.notes ?? 'No notes', style: const TextStyle(color: Colors.white, fontSize: 14)),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => EditPasswordScreen(passwordItem: passwordItem)),
                      );
                    },
                    child: const Text('Edit', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Provider.of<VaultViewModel>(context, listen: false).removePassword(passwordItem.id);
                      Navigator.pop(context);
                    },
                    child: const Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.w500));
  }
}
