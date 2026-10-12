import '../models/password_model.dart';

class VaultService {
  final List<PasswordModel> _passwords = [
    PasswordModel(
      id: '1',
      title: 'Google',
      username: 'alex@gmail.com',
      password: 'SecurePassword123!',
      notes: 'Personal Google account',
      category: 'Google',
    ),
    PasswordModel(
      id: '2',
      title: 'YouTube',
      username: 'alex@gmail.com',
      password: 'TubeUserPass99#',
      notes: 'Streaming account',
      category: 'YouTube',
    ),
    PasswordModel(
      id: '3',
      title: 'Facebook',
      username: 'alex@gmail.com',
      password: 'FBLoginSecure88',
      notes: 'Social account',
      category: 'Facebook',
    ),
    PasswordModel(
      id: '4',
      title: 'GitHub',
      username: 'alex@gmail.com',
      password: 'ghp_developerKey992!',
      notes: 'Code repository',
      category: 'GitHub',
    ),
    PasswordModel(
      id: '5',
      title: 'Amazon',
      username: 'alex@gmail.com',
      password: 'AmazonShoppingPass#1',
      notes: 'Shopping account',
      category: 'Amazon',
    ),
  ];

  Future<List<PasswordModel>> getPasswords() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_passwords);
  }

  Future<void> addPassword(PasswordModel password) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _passwords.add(password);
  }

  Future<void> updatePassword(PasswordModel updated) async {
    await Future.delayed(const Duration(milliseconds: 150));
    int index = _passwords.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _passwords[index] = updated;
    }
  }

  Future<void> deletePassword(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _passwords.removeWhere((item) => item.id == id);
  }
}
