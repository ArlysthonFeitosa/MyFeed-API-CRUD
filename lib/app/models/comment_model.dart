import 'dart:convert';

class CommentModel {
  final String postId;
  final String commentId;
  final String ownerAvatarURL;
  final String ownerUsername;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.ownerAvatarURL,
    required this.ownerUsername,
    required this.content,
    required this.createdAt,
  });

  CommentModel copyWith({
    String? commentId,
    String? postId,
    String? ownerAvatarURL,
    String? ownerUsername,
    String? content,
    DateTime? createdAt,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      ownerAvatarURL: ownerAvatarURL ?? this.ownerAvatarURL,
      ownerUsername: ownerUsername ?? this.ownerUsername,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'CommentModel(createdAt: $createdAt, commentId: $commentId, ownerAvatarURL: $ownerAvatarURL, ownerUsername: $ownerUsername, content: $content, postId: $postId)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': commentId,
      'postId': postId,
      'avatar': ownerAvatarURL,
      'username': ownerUsername,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['id'],
      postId: map['postId'] as String,
      ownerAvatarURL: map['avatar'] as String,
      ownerUsername: map['username'] as String,
      content: map['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
