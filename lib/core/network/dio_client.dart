import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final token = dotenv.env['TMDB_TOKEN'];
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final envToken = dotenv.env['TMDB_TOKEN'];
          if (envToken != null && envToken.isNotEmpty &&
              (options.headers['Authorization'] == null ||
                  (options.headers['Authorization'] as String).isEmpty)) {
            options.headers['Authorization'] = 'Bearer $envToken';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final shouldRetry = error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.connectionTimeout;

          if (shouldRetry) {
            final req = error.requestOptions;
            final currentAttempts = (req.extra['retry_attempt'] as int?) ?? 0;
            if (currentAttempts < 3) {
              final nextAttempts = currentAttempts + 1;
              req.extra['retry_attempt'] = nextAttempts;
              final delayMs = 400 * nextAttempts; // 400ms, 800ms, 1200ms
              await Future.delayed(Duration(milliseconds: delayMs));
              try {
                final response = await dio.fetch(req);
                return handler.resolve(response);
              } catch (e) {
                return handler.next(error);
              }
            }
          }
          handler.next(error);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        compact: true,
      ),
    );

    return dio;
  }
}
