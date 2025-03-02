import 'dart:convert';

class QuestionModel {
	String? id;
	String? description;
	bool? isPublic;
	String? createdAt;
	String? updatedAt;
	int? v;

	QuestionModel({
		this.id, 
		this.description, 
		this.isPublic, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	factory QuestionModel.fromMap(Map<String, dynamic> data) => QuestionModel(
				id: data['_id'] as String?,
				description: data['description'] as String?,
				isPublic: data['isPublic'] as bool?,
				createdAt: data['createdAt'] as String?,
				updatedAt: data['updatedAt'] as String?,
				v: data['__v'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'_id': id,
				'description': description,
				'isPublic': isPublic,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionModel].
	factory QuestionModel.fromJson(String data) {
		return QuestionModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [QuestionModel] to a JSON string.
	String toJson() => json.encode(toMap());
}
