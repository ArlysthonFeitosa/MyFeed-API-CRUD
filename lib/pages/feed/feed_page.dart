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
    List<PostModel> posts = context.watch<FeedViewmodel>().posts;
    bool reachedMax = context.watch<FeedViewmodel>().reachedMax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFeed'),
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return feedViewmodel.refreshData();
        },
        child: ListView.builder(
          controller: feedViewmodel.scrollController,
          itemCount: posts.length + 1,
          itemBuilder: ((context, index) {
            if (index == posts.length) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: reachedMax ? const Text('No more posts') : const CircularProgressIndicator(),
                ),
              );
            }
      
            PostModel post = feedViewmodel.posts[index];
      
            return PostComponent(postModel: post);
          }),
        ),
      ),
    );
  }
}
