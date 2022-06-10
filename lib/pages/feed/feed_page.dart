import 'package:flutter/material.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/pages/feed/feed_viewmodel.dart';
import 'package:myfeed/utils/components/components.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage._({Key? key}) : super(key: key);

  static Widget create() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => FeedViewmodel(c.read<PostsRepository>())),
      ],
      child: const FeedPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    FeedViewmodel feedViewmodel = context.read<FeedViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SocialMedia'),
      ),
      body: ListView.builder(
        controller: feedViewmodel.scrollController,
        itemCount: context.watch<FeedViewmodel>().posts.length,
        itemBuilder: ((context, index) {
          PostModel post = feedViewmodel.posts[index];

          return PostComponent(postModel: post);
        }),
      ),
    );
  }
}
