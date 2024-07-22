class User {
  final String? id;
  final String? fullName;
  final String? username;
  final String? email;

  User({this.id, this.fullName, this.username, this.email});

  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, username: $username, email: $email}';
  }
}
