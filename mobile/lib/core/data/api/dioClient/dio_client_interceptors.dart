import 'package:dio/dio.dart';
import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/core/domain/repo/repo.dart';
import 'package:mobile/features/auth/data/model/model.dart';

import '../../../constant/text.dart';

class DioClientInterceptors extends Interceptor {
  final SecureStorageRepo _sRepo;

  final Dio _dio;
  bool _isRequesting = false;
  DioClientInterceptors(this._sRepo, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var accessToken = await _sRepo.get<String>(key: aceessTokenKey);
    if (accessToken != null) {
      accessToken = accessToken.replaceAll('"', '');
      options.headers["Authorization"] = "Bearer ${accessToken.toString()}";
    }

    if (options.extra["form"] == true) {
      options.contentType = Headers.formUrlEncodedContentType;
      options.data = Map<String, dynamic>.from(options.data);
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.reject(err);
    }

    if (_isRequesting) {
      return handler.reject(err);
    }

    final opaqueToken = await _sRepo.get<String>(key: opaqueTokenKey);
    if (opaqueToken == null) {
      return handler.reject(err);
    }
    var fromattedOpaqueToken = opaqueToken.replaceAll('"', '');
    _isRequesting = true;

    try {
      final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl))
        ..interceptors.clear();
      final refreshRes = await refreshDio.post(
        'auth/refresh-token',
        data: {'token': fromattedOpaqueToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (_) => true,
        ),
      );
      final output = DefaultApiResponse.fromJson(
        refreshRes.data,
        (val) => AccessTokenModel.fromJson(val as Map<String, dynamic>),
      );

      final cleanToken = output.data.token.replaceAll('"', '');

      await _sRepo.set<String>(key: aceessTokenKey, value: cleanToken);

      final retryDio = Dio(_dio.options)..interceptors.clear();

      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $cleanToken';

      _isRequesting = false;

      final retryResponse = await retryDio.fetch(opts);
      return handler.resolve(retryResponse);
    } catch (e) {
      _isRequesting = false;
      return handler.reject(err);
    }
  }
}
