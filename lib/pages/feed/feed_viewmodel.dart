import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/interfaces/exceptions/handled_exception_interface.dart';
import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/models/post_model.dart';

class FeedViewmodel extends ChangeNotifier {
  final IPostsRepository postsRepository;

  FeedViewmodel(this.postsRepository) {
    fetchPosts();
    setListeners();
  }

  bool reachedMax = false;
  int _page = 1;
  final int _limit = 5;
  List<PostModel> posts = [];
  final ScrollController scrollController = ScrollController();

  void setListeners() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        fetchPosts();
      }
    });
  }

  void incrementPage() {
    _page++;
  }

  Future<void> refreshData() async {
    _page = 1;
    reachedMax = false;
    posts.clear();
    fetchPosts();
  }

  Future<String?> fetchPosts() async {
    if (reachedMax) return null;
    try {
      List<PostModel> postsResponse = await postsRepository.getAllPosts(
        page: _page,
        limit: _limit,
      );

      incrementPage();

      if (postsResponse.isEmpty) {
        reachedMax = true;
      }

      posts.addAll(postsResponse);

      notifyListeners();
      return null;
    } on HandledException catch (e) {
      return e.toString();
    }
  }
}
