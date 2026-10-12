import 'package:flutter/foundation.dart';
import '../models/password_model.dart';
import '../services/vault_service.dart';

class VaultViewModel extends ChangeNotifier {
  final VaultService _vaultService = VaultService();

  List<PasswordModel> _passwords = [];
  String _searchQuery = '';
  bool _isLoading = false;

  List<PasswordModel> get passwords {
    if (_searchQuery.isEmpty) {
      return _passwords;
    }
    return _passwords.where((p) =>
      p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      p.username.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  int get totalCount => _passwords.length;
  int get strongCount => _passwords.where((p) => p.password.length >= 12).length;
  int get weakCount => totalCount - strongCount;

  Future<void> loadPasswords() async {
    _isLoading = true;
    notifyListeners();
    try {
      _passwords = await _vaultService.getPasswords();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> addNewPassword(PasswordModel newPassword) async {
    await _vaultService.addPassword(newPassword);
    await loadPasswords();
  }

  Future<void> updateExistingPassword(PasswordModel updated) async {
    await _vaultService.updatePassword(updated);
    await loadPasswords();
  }

  Future<void> removePassword(String id) async {
    await _vaultService.deletePassword(id);
    await loadPasswords();
  }
}
