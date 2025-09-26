import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';

class MoviesApi {
  final Dio _dio;
  MoviesApi({Dio? dio}) : _dio = dio ?? DioClient.create();

  Future<Map<String, dynamic>> _get(String path, {Map<String, dynamic>? query}) async {
    try {
      final res = await _dio.get(path, queryParameters: query);
      return res.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final message = e.response?.data is Map<String, dynamic>
          ? (e.response?.data['status_message'] as String?)
          : e.message;
      throw ServerException(message ?? 'Network error', statusCode: status);
    } catch (e) {
      throw ServerException('Unknown error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPopularMovies({int page = 1}) async {
    final json = await _get('/movie/popular', query: {
      'language': 'en-US',
      'page': page,
    });
    return (json['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query, {int page = 1}) async {
    final json = await _get('/search/movie', query: {
      'query': query,
      'include_adult': false,
      'language': 'en-US',
      'page': page,
    });
    return (json['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    return _get('/movie/$id', query: {
      'language': 'en-US',
    });
  }
}
