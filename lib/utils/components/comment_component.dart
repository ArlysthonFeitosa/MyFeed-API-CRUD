import 'package:flutter/material.dart';
import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/utils/components/components.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({
    required this.commentModel,
    required this.onDeleteComment,
    required this.onEditComment,
    Key? key,
  }) : super(key: key);

  final CommentModel commentModel;
  final Function(BuildContext context) onDeleteComment;
  final Function(BuildContext context) onEditComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            UserHeaderComponent(
              username: commentModel.ownerUsername,
              avatar: commentModel.ownerAvatarURL,
            ),
            const Expanded(child: SizedBox()),
            PopupMenuButton(
              itemBuilder: (context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      onEditComment(context);
                    },
                    child: const Text('Edit'),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      onDeleteComment(context);
                    },
                    child: const Text('Delete'),
                  ),
                ];
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(commentModel.content),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
