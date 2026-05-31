import 'package:dio/dio.dart';

import '../data/api/api.dart';
import '../data/model/model.dart';

class DefaultResReturn {
  static DefaultApiResponse<T> exception<T>(DioException e,{required T data}) {
    final res = e.response;
    final body = res?.data;

    return DefaultApiResponse(
      message: DioExceptionHandler.handle(e),
      statusCode: body is Map && body['status_code'] != null
          ? body['status_code']
          : res?.statusCode ?? 100,
      data: data,
      successful: false,
    );
  }
}
