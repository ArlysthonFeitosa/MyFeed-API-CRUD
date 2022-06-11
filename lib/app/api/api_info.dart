String baseURL = 'https://62a1ed6ecd2e8da9b0febacf.mockapi.io';

String postsEndpoint({int? page, int? limit}) {
  if (page == null && limit == null) return '$baseURL/posts';
  return '$baseURL/posts?page=$page&limit=$limit';
}

String commentsFromPost({required String postId,int? page, int? limit}) {
  if (page == null && limit == null) return '$baseURL/posts/$postId/comments';
  return '$baseURL/posts/$postId/comments?page=$page&limit=$limit';
}

String createCommentEndpoint({required String postId}) => '$baseURL/posts/$postId/comments';
String updateCommentEndpoint({required String postId, required String commentId}) => '$baseURL/posts/$postId/comments/$commentId';
String deleteCommentEndpoint({required String postId, required String commentId}) => '$baseURL/posts/$postId/comments/$commentId';
