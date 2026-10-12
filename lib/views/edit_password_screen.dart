import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/password_model.dart';
import '../viewmodels/vault_viewmodel.dart';

class EditPasswordScreen extends StatefulWidget {
  final PasswordModel passwordItem;
  const EditPasswordScreen({super.key, required this.passwordItem});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  late TextEditingController _titleController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.passwordItem.title);
    _usernameController = TextEditingController(text: widget.passwordItem.username);
    _passwordController = TextEditingController(text: widget.passwordItem.password);
    _notesController = TextEditingController(text: widget.passwordItem.notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit Password', style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildLabel('Website / App'),
            const SizedBox(height: 8),
            _buildTextField(_titleController),
            const SizedBox(height: 16),
            _buildLabel('Username / Email'),
            const SizedBox(height: 8),
            _buildTextField(_usernameController),
            const SizedBox(height: 16),
            _buildLabel('Password'),
            const SizedBox(height: 8),
            _buildTextField(_passwordController),
            const SizedBox(height: 16),
            _buildLabel('Notes'),
            const SizedBox(height: 8),
            _buildTextField(_notesController, maxLines: 3),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final updated = PasswordModel(
                    id: widget.passwordItem.id,
                    title: _titleController.text,
                    username: _usernameController.text,
                    password: _passwordController.text,
                    notes: _notesController.text,
                    category: _titleController.text,
                  );
                  Provider.of<VaultViewModel>(context, listen: false).updateExistingPassword(updated);
                  Navigator.pop(context);
                },
                child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(color: Colors.white60, fontSize: 13));

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
