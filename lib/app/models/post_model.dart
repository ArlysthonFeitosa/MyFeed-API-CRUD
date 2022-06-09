// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myfeed/app/models/comment_model.dart';

class PostModel {
  final String postId;
  final String ownerUsername;
  final String ownerAvatarURL;
  final String content;
  final List<CommentModel> comments;

  PostModel({
    required this.postId,
    required this.ownerUsername,
    required this.ownerAvatarURL,
    required this.content,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> commentsMap = [];

    for (CommentModel comment in comments) {
      commentsMap.add(comment.toMap());
    }

    return <String, dynamic>{
      'postId': postId,
      'ownerUsername': ownerUsername,
      'ownerAvatar': ownerAvatarURL,
      'content': content,
      'comments': commentsMap,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> commentsMap = map['comments'];

    List<CommentModel> commentsModels = [];
    for (Map<String, dynamic> map in commentsMap) {
      commentsModels.add(CommentModel.fromMap(map));
    }

    return PostModel(
      postId: map['id'] as String,
      ownerUsername: map['ownerUsername'] as String,
      ownerAvatarURL: map['ownerAvatar'] as String,
      content: map['content'] as String,
      comments: commentsModels,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? postId,
    String? ownerUsername,
    String? ownerAvatarURL,
    String? content,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      postId: postId ?? this.ownerUsername,
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
