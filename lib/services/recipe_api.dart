import 'package:dio/dio.dart';

class RecipeApi {
  static const String _baseUrl = 'https://api.edamam.com';
  static const String _appId = '7af43eda';
  static const String _appKey = '3717e7d81c822e38da98fccffd14e944';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      queryParameters: {
        'app_id': _appId,
        'app_key': _appKey,
      },
    ),
  );

  Future<List<dynamic>> searchRecipes(String query) async {
    try {
      final response = await _dio.get('/search', queryParameters: {'q': query});

      if (response.statusCode == 200) {
        final hits = response.data['hits'] as List<dynamic>;
        return hits.map((hit) => hit['recipe']).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }
}
