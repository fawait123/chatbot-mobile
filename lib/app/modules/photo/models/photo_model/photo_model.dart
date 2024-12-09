import 'dart:convert';

import 'user_id.dart';

class PhotoModel {
	String? id;
	String? date;
	String? source;
	UserId? userId;
	String? createdAt;
	String? updatedAt;
	int? v;

	PhotoModel({
		this.id, 
		this.date, 
		this.source, 
		this.userId, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	factory PhotoModel.fromMap(Map<String, dynamic> data) => PhotoModel(
				id: data['_id'] as String?,
				date: data['date'] as String?,
				source: data['source'] as String?,
				userId: data['userID'] == null
						? null
						: UserId.fromMap(data['userID'] as Map<String, dynamic>),
				createdAt: data['createdAt'] as String?,
				updatedAt: data['updatedAt'] as String?,
				v: data['__v'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'_id': id,
				'date': date,
				'source': source,
				'userID': userId?.toMap(),
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PhotoModel].
	factory PhotoModel.fromJson(String data) {
		return PhotoModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [PhotoModel] to a JSON string.
	String toJson() => json.encode(toMap());
}
