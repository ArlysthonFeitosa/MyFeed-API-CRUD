import 'dart:convert';

class CommentModel {
  final String ownerAvatarURL;
  final String ownerUsername;
  final String content;

  CommentModel({
    required this.ownerAvatarURL,
    required this.ownerUsername,
    required this.content,
  });

  CommentModel copyWith({
    String? ownerAvatarURL,
    String? ownerUsername,
    String? content,
  }) {
    return CommentModel(
      ownerAvatarURL: ownerAvatarURL ?? this.ownerAvatarURL,
      ownerUsername: ownerUsername ?? this.ownerUsername,
      content: content ?? this.content,
    );
  }

  @override
  String toString() => 'CommentModel(ownerAvatarURL: $ownerAvatarURL, ownerUsername: $ownerUsername, content: $content)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ownerAvatarURL': ownerAvatarURL,
      'ownerUsername': ownerUsername,
      'content': content,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      ownerAvatarURL: map['ownerAvatarURL'] as String,
      ownerUsername: map['ownerUsername'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
