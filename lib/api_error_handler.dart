import 'package:dio/dio.dart';
import 'package:test_app/error_model.dart';

/// Enumeration representing different data source types and error scenarios.
enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

/// Response codes for different API outcomes.
class ResponseCode {
  static const int success = 200; // Success with data
  static const int noContent = 204; // Success with no data (no content)
  static const int badRequest = 400; // Failure, API rejected request
  static const int unauthorized = 401; // Failure, user is not authorized
  static const int forbidden = 403; // Failure, API rejected request
  static const int notFound = 404; // Failure, not found
  static const int internalServerError = 500; // Failure, server-side crash

  // Local status codes
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

/// Response messages for different error scenarios.
class ResponseMessage {
  static const String noContent = ApiErrors.noContent;
  static const String badRequest = ApiErrors.badRequestError;
  static const String unauthorized = ApiErrors.unauthorizedError;
  static const String forbidden = ApiErrors.forbiddenError;
  static const String notFound = ApiErrors.notFoundError;
  static const String internalServerError = ApiErrors.internalServerError;

  // Local status messages
  static const String connectTimeout = ApiErrors.timeoutError;
  static const String cancel = ApiErrors.defaultError;
  static const String receiveTimeout = ApiErrors.timeoutError;
  static const String sendTimeout = ApiErrors.timeoutError;
  static const String cacheError = ApiErrors.cacheError;
  static const String noInternetConnection = ApiErrors.noInternetError;
  static const String defaultError = ApiErrors.defaultError;
}

/// Extension to convert DataSource to ApiErrorModel.
extension DataSourceExtension on DataSource {
  ErrorModel getFailure() {
    switch (this) {
      case DataSource.noContent:
        return ErrorModel(
            falid: ResponseCode.noContent, massage: ResponseMessage.noContent);
      case DataSource.badRequest:
        return ErrorModel(
            falid: ResponseCode.badRequest,
            massage: ResponseMessage.badRequest);
      case DataSource.forbidden:
        return ErrorModel(
            falid: ResponseCode.forbidden, massage: ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return ErrorModel(
            falid: ResponseCode.unauthorized,
            massage: ResponseMessage.unauthorized);
      case DataSource.notFound:
        return ErrorModel(
            falid: ResponseCode.notFound, massage: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return ErrorModel(
            falid: ResponseCode.internalServerError,
            massage: ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return ErrorModel(
            falid: ResponseCode.connectTimeout,
            massage: ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return ErrorModel(
            falid: ResponseCode.cancel, massage: ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return ErrorModel(
            falid: ResponseCode.receiveTimeout,
            massage: ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return ErrorModel(
            falid: ResponseCode.sendTimeout,
            massage: ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return ErrorModel(
            falid: ResponseCode.cacheError,
            massage: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return ErrorModel(
            falid: ResponseCode.noInternetConnection,
            massage: ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return ErrorModel(
            falid: ResponseCode.defaultError,
            massage: ResponseMessage.defaultError);
    }
  }
}

/// Custom exception class to handle API errors.
class ErrorHandler implements Exception {
  late final ErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // Handle Dio errors (API or Dio itself)
      apiErrorModel = _handleError(error);
    } else {
      // Handle default errors
      apiErrorModel = DataSource.defaultError.getFailure();
    }
  }
}

/// Private function to handle Dio errors and convert them to ApiErrorModel.
ErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null && error.response!.data != null) {
        return ErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();
  }
}

/// Internal status codes for API responses.
class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}

/// Error messages for different error scenarios.
class ApiErrors {
  static const String badRequestError = "Bad Request Error";
  static const String noContent = "No Content";
  static const String forbiddenError = "Forbidden Error";
  static const String unauthorizedError = "Unauthorized Error";
  static const String notFoundError = "Not Found Error";
  static const String conflictError = "Conflict Error";
  static const String internalServerError = "Internal Server Error";
  static const String unknownError = "Unknown Error";
  static const String timeoutError = "Timeout Error";
  static const String defaultError = "Default Error";
  static const String cacheError = "Cache Error";
  static const String noInternetError = "No Internet Connection Error";
  static const String loadingMessage = "Loading...";
  static const String retryAgainMessage = "Please try again";
  static const String ok = "Ok";
}
