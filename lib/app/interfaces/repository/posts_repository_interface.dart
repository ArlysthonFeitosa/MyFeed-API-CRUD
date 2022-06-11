import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/app/models/post_model.dart';

abstract class IPostsRepository {
  Future<List<PostModel>> getAllPosts({int? page, int? limit});
  Future<List<CommentModel>> getCommentsFromPost({required int postId,int? page, int? limit});
  Future<void> createComment({required CommentModel commentModel});
  Future<void> updateComment({required CommentModel commentModel});
  Future<void> deleteComment({required CommentModel commentModel});
}
