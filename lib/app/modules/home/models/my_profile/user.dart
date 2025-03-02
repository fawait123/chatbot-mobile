import 'dart:convert';

class User {
  String? username;
  String? email;
  String? name;
  String? role;
  String? sub;
  String? id;

  User({this.username, this.email, this.name, this.role, this.sub, this.id});

  factory User.fromMap(Map<String, dynamic> data) => User(
      username: data['username'] as String?,
      email: data['email'] as String?,
      name: data['name'] as String?,
      role: data['role'] as String?,
      sub: data['sub'] as String?,
      id: data['_id'] as String?);

  Map<String, dynamic> toMap() => {
        'username': username,
        'email': email,
        'name': name,
        'role': role,
        'sub': sub,
        'id': id
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
