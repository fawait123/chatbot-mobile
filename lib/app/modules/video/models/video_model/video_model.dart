import 'dart:convert';

class VideoModel {
	String? id;
	String? title;
	String? description;
	String? thumbnail;
	String? source;
	bool? isPublic;
	String? createdAt;
	String? updatedAt;
	int? v;

	VideoModel({
		this.id, 
		this.title, 
		this.description, 
		this.thumbnail, 
		this.source, 
		this.isPublic, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	factory VideoModel.fromMap(Map<String, dynamic> data) => VideoModel(
				id: data['_id'] as String?,
				title: data['title'] as String?,
				description: data['description'] as String?,
				thumbnail: data['thumbnail'] as String?,
				source: data['source'] as String?,
				isPublic: data['is_public'] as bool?,
				createdAt: data['createdAt'] as String?,
				updatedAt: data['updatedAt'] as String?,
				v: data['__v'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'_id': id,
				'title': title,
				'description': description,
				'thumbnail': thumbnail,
				'source': source,
				'is_public': isPublic,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VideoModel].
	factory VideoModel.fromJson(String data) {
		return VideoModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [VideoModel] to a JSON string.
	String toJson() => json.encode(toMap());
}
