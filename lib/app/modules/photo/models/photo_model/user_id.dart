import 'dart:convert';

class UserId {
	String? id;
	String? name;
	String? username;
	String? email;
	String? password;
	String? role;
	bool? status;
	String? createdAt;
	String? updatedAt;
	int? v;

	UserId({
		this.id, 
		this.name, 
		this.username, 
		this.email, 
		this.password, 
		this.role, 
		this.status, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	factory UserId.fromMap(Map<String, dynamic> data) => UserId(
				id: data['_id'] as String?,
				name: data['name'] as String?,
				username: data['username'] as String?,
				email: data['email'] as String?,
				password: data['password'] as String?,
				role: data['role'] as String?,
				status: data['status'] as bool?,
				createdAt: data['createdAt'] as String?,
				updatedAt: data['updatedAt'] as String?,
				v: data['__v'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'_id': id,
				'name': name,
				'username': username,
				'email': email,
				'password': password,
				'role': role,
				'status': status,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserId].
	factory UserId.fromJson(String data) {
		return UserId.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [UserId] to a JSON string.
	String toJson() => json.encode(toMap());
}
