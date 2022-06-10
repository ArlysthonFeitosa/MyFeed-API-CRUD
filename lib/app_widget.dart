import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/app/services/dio_http_service.dart';
import 'package:myfeed/pages/feed/feed_page.dart';
import 'package:myfeed/pages/route_handler.dart';
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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
      routes: {
        '/': (c) => FeedPage.create(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}
