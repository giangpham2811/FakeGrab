import 'package:app/app_env.dart';
import 'package:app/src/data/preferences/session_preferences.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_api.dart';

class AppClient {
  late AppApi appApi;

  AppClient._privateConstructor() {
    _setupClient();
  }

  static final AppClient _instance = AppClient._privateConstructor();

  factory AppClient() {
    return _instance;
  }

  void _setupClient() {
    SessionPreferences _sessionPreferences = SessionPreferences();
    final Dio _dio = Dio();
    _dio
      ..options.connectTimeout = 30 * 1000
      ..options.receiveTimeout = 30 * 1000
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'}
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 1000,
      ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await _sessionPreferences.authToken;
        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        return handler.next(options);
      },
      onResponse: (options, handler) async {
        // TODO
        return handler.next(options);
      },
    ));
    appApi = AppApi(_dio, baseUrl: AppEnv.config.serverUrl);
  }
}

final AppApi appApi = AppClient().appApi;
