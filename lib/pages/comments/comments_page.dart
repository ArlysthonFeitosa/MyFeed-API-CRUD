import 'package:flutter/material.dart';
import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/pages/comments/comments_viewmodel.dart';
import 'package:myfeed/utils/components/comment_component.dart';
import 'package:myfeed/utils/components/components.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage._({
    Key? key,
  }) : super(key: key);

  static Widget create({required PostModel postModel}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => CommentsViewmodel(
            postsRepository: c.read<PostsRepository>(),
            postModel: postModel,
          ),
        ),
      ],
      child: const CommentsPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    PostModel postModel = context.watch<CommentsViewmodel>().postModel;
    List<CommentModel> comments = context.watch<CommentsViewmodel>().comments;
    bool reachedMax = context.watch<CommentsViewmodel>().reachedMax;

    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: SingleChildScrollView(
        controller: context.watch<CommentsViewmodel>().scrollController,
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
              Row(
                children: [
                  Flexible(
                    child: Form(
                      key: context.read<CommentsViewmodel>().newCommentFormkey,
                      child: Column(
                        children: [
                          TextFieldComponent(
                            hint: 'Write a comment...',
                            controller: context.read<CommentsViewmodel>().newCommentFieldController,
                            validation: (text) {
                              return context.read<CommentsViewmodel>().newCommentFieldValidation(text: text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      String? response = await context.read<CommentsViewmodel>().sendComment(); //

                      if (response == null) {
                        await context.read<CommentsViewmodel>().refreshData();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length + 1,
                itemBuilder: (context, index) {
                  if (index == comments.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: reachedMax ? const Text('No more comments') : const CircularProgressIndicator(),
                      ),
                    );
                  }

                  CommentModel commentModel = comments[index];

                  return CommentComponent(
                    commentModel: commentModel,
                    onEditComment: (c) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        showEditCommentDialog(
                          context: context,
                          commentModel: commentModel,
                          viewmodel: c.read<CommentsViewmodel>(),
                        );
                      });
                    },
                    onDeleteComment: (BuildContext context) {
                      context.read<CommentsViewmodel>().deleteComment(commentModel: commentModel);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEditCommentDialog({
    required BuildContext context,
    required CommentModel commentModel,
    required CommentsViewmodel viewmodel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final controller = viewmodel.editCommentFieldController;
        controller.text = commentModel.content;

        return AlertDialog(
          title: Text(commentModel.ownerUsername),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () async {
                if (viewmodel.validateEditCommentField()) {
                  viewmodel.editComment(
                    commentModel: commentModel.copyWith(
                      content: controller.text,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            )
          ],
          content: Row(
            children: [
              Flexible(
                child: Form(
                  key: viewmodel.editCommentFormkey,
                  child: TextFieldComponent(
                    hint: 'Edit comment',
                    controller: viewmodel.editCommentFieldController,
                    validation: (text) {
                      return viewmodel.editCommentFieldValidation(
                        text: text,
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.text = '';
                },
                icon: const Icon(Icons.clear),
              )
            ],
          ),
        );
      },
    );
  }
}
