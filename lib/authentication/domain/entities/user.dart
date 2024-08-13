class User {
  final String? id;
  final String? fullName;
  final String? username;
  final String? email;

  User({this.id, this.fullName, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] ?? '',
        fullName: json['fullName'] ?? '',
        username: json['username'] ?? '',
        email: json['email'] ?? '');
  }

  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, username: $username, email: $email}';
  }
}
