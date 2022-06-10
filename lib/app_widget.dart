import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/app/services/dio_http_service.dart';
import 'package:myfeed/pages/feed_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget._({Key? key}) : super(key: key);

  static Widget create() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) {
          return PostsRepository(httpService: DioHttpService(dio: Dio()));
        })),
      ],
      child: const AppWidget._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFeed',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: FeedPage.create(),
    );
  }
}
