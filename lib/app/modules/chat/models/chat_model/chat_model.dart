import 'dart:convert';

class ChatModel {
	String? id;
	String? message;
	String? response;
	String? userId;
	String? createdAt;
	String? updatedAt;
	int? v;

	ChatModel({
		this.id, 
		this.message, 
		this.response, 
		this.userId, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	factory ChatModel.fromMap(Map<String, dynamic> data) => ChatModel(
				id: data['_id'] as String?,
				message: data['message'] as String?,
				response: data['response'] as String?,
				userId: data['userID'] as String?,
				createdAt: data['createdAt'] as String?,
				updatedAt: data['updatedAt'] as String?,
				v: data['__v'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'_id': id,
				'message': message,
				'response': response,
				'userID': userId,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatModel].
	factory ChatModel.fromJson(String data) {
		return ChatModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ChatModel] to a JSON string.
	String toJson() => json.encode(toMap());
}
