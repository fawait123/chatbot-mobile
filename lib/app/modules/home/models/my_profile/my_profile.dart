import 'dart:convert';

import 'user.dart';

class MyProfile {
	String? token;
	User? user;

	MyProfile({this.token, this.user});

	factory MyProfile.fromMap(Map<String, dynamic> data) => MyProfile(
				token: data['token'] as String?,
				user: data['user'] == null
						? null
						: User.fromMap(data['user'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toMap() => {
				'token': token,
				'user': user?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MyProfile].
	factory MyProfile.fromJson(String data) {
		return MyProfile.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [MyProfile] to a JSON string.
	String toJson() => json.encode(toMap());
}
