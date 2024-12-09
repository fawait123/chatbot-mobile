import 'dart:convert';

class DashboardModel {
	int? user;
	int? video;
	int? capture;
	int? question;

	DashboardModel({this.user, this.video, this.capture, this.question});

	factory DashboardModel.fromMap(Map<String, dynamic> data) {
		return DashboardModel(
			user: data['user'] as int?,
			video: data['video'] as int?,
			capture: data['capture'] as int?,
			question: data['question'] as int?,
		);
	}



	Map<String, dynamic> toMap() => {
				'user': user,
				'video': video,
				'capture': capture,
				'question': question,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DashboardModel].
	factory DashboardModel.fromJson(String data) {
		return DashboardModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [DashboardModel] to a JSON string.
	String toJson() => json.encode(toMap());
}
