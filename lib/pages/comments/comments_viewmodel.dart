import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/interfaces/exceptions/handled_exception_interface.dart';
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

  void incrementPage() {
    _page++;
  }

  Future<String?> fetchComments() async {
    if (reachedMax) return null;
    try {
      List<CommentModel> commentsResponse = await postsRepository.getCommentsFromPost(
        postId: postModel.postId,
        limit: _limit,
        page: _page,
      );
      
      incrementPage();

      if (commentsResponse.isEmpty) {
        reachedMax = true;
      }

      comments.addAll(commentsResponse);
      notifyListeners();
      return null;
    } on HandledException catch (e) {
      return e.toString();
    }
  }
}
