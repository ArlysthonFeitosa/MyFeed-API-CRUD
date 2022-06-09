import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/interfaces/services/http_service_interface.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/models/comment_model.dart';

class PostsRepository implements IPostsRepository {
  final IHttpService httpService;

  PostsRepository({required this.httpService});

  String baseURL = 'https://62a1ed6ecd2e8da9b0febacf.mockapi.io';

  String postsEndpoint({int? page, int? limit}) {
    if (page == null && limit == null) return '$baseURL/posts';
    return '$baseURL/posts?page=$page&limit=$limit';
  }

  String createCommentEndpoint({required String postId}) => '$baseURL/posts/$postId/comments';
  String updateCommentEndpoint({required String postId, required String commentId}) => '$baseURL/posts/$postId/comments/$commentId';
  String deleteCommentEndpoint({required String postId, required String commentId}) => '$baseURL/posts/$postId/comments/$commentId';

  @override
  Future<List<PostModel>> getAllPosts({
    int? page,
    int? limit,
  }) async {
    List<Map<String, dynamic>> response = await httpService.get(
      url: postsEndpoint(page: page, limit: limit),
    );

    List<PostModel> posts = [];
    for (var map in response) {
      posts.add(PostModel.fromMap(map));
    }

    return posts;
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
      url: updateCommentEndpoint(postId: commentModel.postId, commentId: commentModel.postId),
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
