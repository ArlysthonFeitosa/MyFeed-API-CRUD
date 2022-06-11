import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/app/models/post_model.dart';

class CommentsViewmodel extends ChangeNotifier {
  CommentsViewmodel({required this.postsRepository, required this.postModel}) {
    fetchComments();
    setListeners();
  }

  final IPostsRepository postsRepository;
  final PostModel postModel;

  ScrollController scrollController = ScrollController();

  void setListeners() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        fetchComments();
      }
    });
  }

  int _page = 1;
  final int _limit = 7;
  bool reachedMax = false;
  List<CommentModel> comments = [];

  Future<void> refreshData() async {
    _page = 1;
    reachedMax = false;
    comments.clear();
    fetchComments();
  }

  Future<void> fetchComments() async {
    if (reachedMax) return;

    List<CommentModel> commentsResponse = await postsRepository.getCommentsFromPost(
      postId: postModel.postId,
      limit: _limit,
      page: _page,
    );

    _page++;
    if (commentsResponse.isEmpty) {
      reachedMax = true;
    }

    comments.addAll(commentsResponse);
    notifyListeners();
  }
}
