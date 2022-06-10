import 'package:flutter/material.dart';
import 'package:myfeed/pages/comments/comments_args.dart';
import 'package:myfeed/pages/comments/comments_page.dart';

Route? Function(RouteSettings) onGenerateRoute = (settings) {
  switch (settings.name) {
    case '/comments':
      return commentsPageRoute(settings: settings);
    default:
      return PageRouteBuilder(pageBuilder: (_, __, ___) => const Scaffold());
  }
};

Route commentsPageRoute({required RouteSettings settings}) {
  CommentsPageArgs args = settings.arguments as CommentsPageArgs;
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: ((_, __, ___) => CommentsPage.create(postModel: args.postModel)),
  );
}
