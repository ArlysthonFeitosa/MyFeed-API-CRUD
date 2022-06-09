import 'dart:convert';

class CommentModel {
  final String postId;
  final String commentId;
  final String ownerAvatarURL;
  final String ownerUsername;
  final String content;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.ownerAvatarURL,
    required this.ownerUsername,
    required this.content,
  });

  CommentModel copyWith({
    String? commentId,
    String? postId,
    String? ownerAvatarURL,
    String? ownerUsername,
    String? content,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      ownerAvatarURL: ownerAvatarURL ?? this.ownerAvatarURL,
      ownerUsername: ownerUsername ?? this.ownerUsername,
      content: content ?? this.content,
    );
  }

  @override
  String toString() =>
      'CommentModel(commentId: $commentId, ownerAvatarURL: $ownerAvatarURL, ownerUsername: $ownerUsername, content: $content, postId: $postId)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'ownerAvatarURL': ownerAvatarURL,
      'ownerUsername': ownerUsername,
      'content': content,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['id'],
      postId: map['postId'] as String,
      ownerAvatarURL: map['ownerAvatarURL'] as String,
      ownerUsername: map['ownerUsername'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
