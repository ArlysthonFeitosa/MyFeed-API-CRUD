import 'package:flutter/material.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/pages/comments/comments_viewmodel.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage._({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;


  static Widget create({required PostModel postModel}) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (c) => CommentsViewmodel())],
      child: CommentsPage._(postModel: postModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(postModel.ownerUsername);
  }
}
