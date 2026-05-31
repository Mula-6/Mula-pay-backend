import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../application/provider/provider.dart';
import 'dio_client_interceptors.dart';

final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.backendApiLink,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {"content-type": "application/json"},
    ),
  );
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      enabled: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  dio.interceptors.add(
    DioClientInterceptors(ref.read(appSecureStorageProvider), dio),
  );
  return dio;
});
