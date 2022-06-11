import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:myfeed/app/api/api_info.dart';
import 'package:myfeed/app/interfaces/exceptions/handled_exception_interface.dart';
import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/interfaces/services/http_service_interface.dart';
import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/app/services/dio_http_service.dart';

import 'responses/all_posts_response.dart';
import 'responses/comments_from_post_response.dart';
import 'responses/posts_paginated_response.dart';

void main() {
  group('GET ALL POSTS METHOD | ', () {
    test('should get all posts', () async {
      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onGet(postsEndpoint(), (server) {
        server.reply(200, jsonDecode(successAllPostsResponse));
      });

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      List<PostModel> posts = await postsRepository.getAllPosts();

      expect(posts, isNotEmpty);
    });

    //DISABLE UNCAUGHT EXCEPTIONS FOR THIS TEST
    test('should not get posts', () async {
      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onGet(postsEndpoint(), (server) {
        server.reply(
          400,
          jsonEncode({
            'error': '400',
          }),
        );
      });

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      expectLater(
        postsRepository.getAllPosts(),
        throwsA(isA<HandledException>()),
      );
    });

    test('should get posts paginated', () async {
      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onGet(postsEndpoint(page: 1, limit: 10), (server) {
        server.reply(200, jsonDecode(postsPaginatedResponse));
      });

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      List<PostModel> posts = await postsRepository.getAllPosts(page: 1, limit: 10);

      expect(posts.length, equals(10));
    });
  });

  group('GET COMMENTS FROM POST', () {
    test('should get comments from post', () async {
      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);

      String postId = '1';

      dioAdapter.onGet(commentsFromPost(postId: postId), (server) {
        server.reply(200, jsonDecode(commentsFromPostResponse));
      });

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      List<CommentModel> comments = await postsRepository.getCommentsFromPost(postId: postId);

      expect(comments, isNotEmpty);
    });
  });

  group('CREATE COMMENT METHOD | ', () {
    //DISABLE UNCAUGHT EXCEPTIONS FOR THIS TEST
    test('should not create comment', () async {
      CommentModel commentModel = CommentModel(
        commentId: 'commentId',
        postId: 'postId',
        ownerAvatarURL: 'ownerAvatarURL',
        ownerUsername: 'ownerUsername',
        content: 'content',
      );

      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
        createCommentEndpoint(
          postId: commentModel.postId,
        ),
        (server) {
          server.reply(400, jsonEncode({"status": "error"}));
        },
        data: commentModel.toMap(),
      );

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      expect(
        () async => await postsRepository.createComment(commentModel: commentModel),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });
  });

  group('UPDATE COMMENT METHOD |', () {
    //DISABLE UNCAUGHT EXCEPTIONS FOR THIS TEST
    test('should not update comment', () async {
      CommentModel commentModel = CommentModel(
        commentId: 'commentId',
        postId: 'postId',
        ownerAvatarURL: 'ownerAvatarURL',
        ownerUsername: 'ownerUsername',
        content: 'content',
      );

      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPut(
        updateCommentEndpoint(
          postId: commentModel.postId,
          commentId: commentModel.commentId,
        ),
        (server) {
          server.reply(400, jsonEncode({"status": "error"}));
        },
        data: commentModel.toMap(),
      );

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      expectLater(
        postsRepository.updateComment(commentModel: commentModel),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });
  });

  group('DELETE COMMENT METHOD |', () {
    test('should not delete comment', () async {
      CommentModel commentModel = CommentModel(
        commentId: 'commentId',
        postId: 'postId',
        ownerAvatarURL: 'ownerAvatarURL',
        ownerUsername: 'ownerUsername',
        content: 'content',
      );
      final Dio dio = Dio();

      final DioAdapter dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onDelete(
          deleteCommentEndpoint(
            postId: commentModel.postId,
            commentId: commentModel.commentId,
          ), (server) {
        server.reply(400, jsonEncode({"status": "error"}));
      });

      dio.httpClientAdapter = dioAdapter;

      final IHttpService httpService = DioHttpService(dio: dio);
      final IPostsRepository postsRepository = PostsRepository(httpService: httpService);

      expectLater(
        postsRepository.deleteComment(commentModel: commentModel),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });
  });
}
