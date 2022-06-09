abstract class IHttpService {
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  });
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  });
  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  });
  Future<dynamic> delete(
      {required String url, Map<String, dynamic>? body, Map<String, dynamic>? headers, Duration timeout = const Duration(seconds: 6)});
}
