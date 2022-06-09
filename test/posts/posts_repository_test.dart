import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:myfeed/app/api/api_info.dart';
import 'package:myfeed/app/interfaces/services/http_service_interface.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/app/services/dio_http_service.dart';

import 'responses.dart';

void main() {
  test('should get all posts', () async {
    final Dio dio = Dio();

    final DioAdapter dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onGet(postsEndpoint(), (server) {
      server.reply(200, jsonDecode(successAllPostsResponse));
    });

    dio.httpClientAdapter = dioAdapter;

    final IHttpService httpService = DioHttpService(dio: dio);
    final PostsRepository postsRepository = PostsRepository(httpService: httpService);

    List<PostModel> posts = await postsRepository.getAllPosts();

    expect(posts, isNotEmpty);
  });
}
