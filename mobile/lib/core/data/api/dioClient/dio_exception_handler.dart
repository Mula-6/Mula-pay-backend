import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please try again.";

      case DioExceptionType.sendTimeout:
        return "Unable to send request. Check your connection.";

      case DioExceptionType.receiveTimeout:
        return "Server is taking too long to respond.";

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return "Request was cancelled.";

      case DioExceptionType.unknown:
      default:
        return "Something went wrong. Please try again.";
    }
  }

  static String _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    if (data is Map && data['message'] != null) {
      return data['message'];
    }

    switch (statusCode) {
      case 400:
        return "Invalid request.";
      case 401:
        return "Unauthorized. Please login again.";
      case 403:
        return "Access denied.";
      case 404:
        return "Resource not found.";
      case 409:
        return "Account already exists.";
      case 429:
        return "Max tries reached. Try again later.";
      case 500:
        return "Server error. Please try later.";
      default:
        return "Unexpected server error.";
    }
  }
}
