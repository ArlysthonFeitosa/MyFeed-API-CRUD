// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myfeed/app/models/comment_model.dart';

class PostModel {
  final String ownerUsername;
  final String ownerAvatarURL;
  final String content;
  final List<CommentModel> comments;

  PostModel({
    required this.ownerUsername,
    required this.ownerAvatarURL,
    required this.content,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ownerUsername': ownerUsername,
      'ownerAvatarURL': ownerAvatarURL,
      'content': content,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      ownerUsername: map['ownerUsername'] as String,
      ownerAvatarURL: map['ownerAvatarURL'] as String,
      content: map['content'] as String,
      comments: List<CommentModel>.from(
        (map['comments'] as List<int>).map<CommentModel>(
          (x) => CommentModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? ownerUsername,
    String? ownerAvatarURL,
    String? content,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      ownerUsername: ownerUsername ?? this.ownerUsername,
      ownerAvatarURL: ownerAvatarURL ?? this.ownerAvatarURL,
      content: content ?? this.content,
      comments: comments ?? this.comments,
    );
  }

  @override
  String toString() {
    return 'PostModel(ownerUsername: $ownerUsername, ownerAvatarURL: $ownerAvatarURL, content: $content, comments: $comments)';
  }
}
