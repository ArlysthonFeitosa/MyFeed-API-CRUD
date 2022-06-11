import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/api/api_info.dart';
import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/interfaces/services/http_service_interface.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/models/comment_model.dart';

class PostsRepository extends ChangeNotifier implements IPostsRepository {
  final IHttpService httpService;

  PostsRepository({required this.httpService});

  @override
  Future<List<PostModel>> getAllPosts({
    int? page,
    int? limit,
  }) async {
    List<dynamic> response = await httpService.get(
      url: postsEndpoint(page: page, limit: limit),
    );

    List<PostModel> posts = [];
    for (Map<String, dynamic> map in response) {
      posts.add(PostModel.fromMap(map));
    }

    return posts;
  }

  @override
  Future<List<CommentModel>> getCommentsFromPost({required String postId, int? page, int? limit}) async {
    List<dynamic> response = await httpService.get(
      url: commentsFromPost(postId: postId, page: page, limit: limit),
    );

    List<CommentModel> comments = [];
    for (Map<String, dynamic> map in response) {
      comments.add(CommentModel.fromMap(map));
    }

    return comments;
  }

  @override
  Future<void> createComment({required CommentModel commentModel}) async {
    return await httpService.post(
      url: createCommentEndpoint(postId: commentModel.postId),
      body: commentModel.toMap(),
    );
  }

  @override
  Future<void> updateComment({required CommentModel commentModel}) async {
    return await httpService.put(
      url: updateCommentEndpoint(postId: commentModel.postId, commentId: commentModel.commentId),
      body: commentModel.toMap(),
    );
  }

  @override
  Future<void> deleteComment({required CommentModel commentModel}) async {
    return await httpService.delete(
      url: deleteCommentEndpoint(
        postId: commentModel.postId,
        commentId: commentModel.commentId,
      ),
    );
  }
}
