import 'package:flutter/material.dart';
import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/pages/comments/comments_viewmodel.dart';
import 'package:myfeed/utils/components/comment_component.dart';
import 'package:myfeed/utils/components/components.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              UserHeaderComponent(
                username: postModel.ownerUsername,
                avatar: postModel.ownerAvatarURL,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(postModel.content),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: postModel.comments.length,
                itemBuilder: (context, index) {
                  CommentModel commentModel = postModel.comments[index];

                  return CommentComponent(commentModel: commentModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
