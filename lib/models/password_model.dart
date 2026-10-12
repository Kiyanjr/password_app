class PasswordModel {
  final String id;
  final String title;
  final String username;
  final String password;
  final String? notes;
  final String category;

  PasswordModel({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    this.notes,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'password': password,
      'notes': notes,
      'category': category,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      notes: map['notes'],
      category: map['category'] ?? '',
    );
  }
}
