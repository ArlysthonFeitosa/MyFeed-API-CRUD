import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/exceptions/exceptions.dart';
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
  final newCommentFormkey = GlobalKey<FormState>();
  final editCommentFormkey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();
  TextEditingController newCommentFieldController = TextEditingController();
  TextEditingController editCommentFieldController = TextEditingController();

  int _page = 1;
  final int _limit = 5;
  bool reachedMax = false;
  List<CommentModel> comments = [];

  void setListeners() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        fetchComments();
      }
    });
  }

  String? newCommentFieldValidation({required String? text}) {
    if (text == null || text.isEmpty) {
      return 'Fill in this field.';
    }
    return null;
  }

  String? editCommentFieldValidation({required String? text}) {
    if (text == null || text.isEmpty) {
      return 'Fill in this field.';
    }
    return null;
  }

  bool validateNewCommentField() {
    if (newCommentFormkey.currentState == null) return false;
    return newCommentFormkey.currentState!.validate();
  }

  bool validateEditCommentField() {
    if (editCommentFormkey.currentState == null) return false;
    return editCommentFormkey.currentState!.validate();
  }

  Future<String?> sendComment() async {
    try {
      if (!validateNewCommentField()) throw TryAgainLaterException();

      String content = newCommentFieldController.text;

      CommentModel commentModel = CommentModel(
        createdAt: DateTime.now(),
        commentId: UniqueKey().toString(),
        postId: postModel.postId,
        ownerAvatarURL: 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1195.jpg',
        ownerUsername: 'MyUsername',
        content: content,
      );

      await postsRepository.createComment(commentModel: commentModel);

      newCommentFieldController.clear();

      return null;
    } on HandledException catch (e) {
      return e.toString();
    }
  }

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

  Future<String?> deleteComment({required CommentModel commentModel}) async {
    try {
      await postsRepository.deleteComment(commentModel: commentModel);
      refreshData();
      notifyListeners();
      return null;
    } on HandledException catch (e) {
      return e.toString();
    }
  }

  Future<String?> editComment({required CommentModel commentModel}) async {
    try {
      await postsRepository.updateComment(commentModel: commentModel);
      refreshData();
      notifyListeners();
      return null;
    } on HandledException catch (e) {
      return e.toString();
    }
  }
}
