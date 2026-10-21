import 'dart:async';
import 'package:dio/dio.dart';
import 'package:stor_app/core/constants/app_strings.dart';
import 'package:stor_app/core/services/errors/failure.dart';

abstract final class DioErrorMapper {
  static Failure map(Object error) {
    if (error is TimeoutException) {
      return const Failure(
        message: AppStrings.theRequestTimedOutPleaseTryAgain,
        code: 'timeout',
      );
    }

    if (error is DioException) {
      return _mapDioException(error);
    }

    if (error is FormatException || error is TypeError) {
      return const Failure(
        message: AppStrings.theReturnedDataCouldNotBeProcessedPleaseTryAgain,
        code: 'invalid_response',
      );
    }

    return const Failure(
      message: AppStrings.anUnexpectedErrorOccurredPleaseTryAgain,
      code: 'unexpected_error',
    );
  }

  static Failure _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const Failure(
          message: AppStrings.connectionTimedOutPleaseTryAgain,
          code: 'connection_timeout',
        );

      case DioExceptionType.sendTimeout:
        return const Failure(
          message: AppStrings.sendTimedOutPleaseTryAgain,
          code: 'send_timeout',
        );

      case DioExceptionType.receiveTimeout:
        return const Failure(
          message: AppStrings.receiveTimedOutPleaseTryAgain,
          code: 'receive_timeout',
        );

      case DioExceptionType.connectionError:
        return const Failure(
          message: AppStrings.noInternetConnectionPleaseTryAgain,
          code: 'connection_error',
        );

      case DioExceptionType.cancel:
        return const Failure(
          message: AppStrings.theRequestWasCancelled,
          code: 'request_cancelled',
        );

      case DioExceptionType.badResponse:
        return _mapStatusCode(error.response?.statusCode, error.response?.data);

      case DioExceptionType.badCertificate:
        return const Failure(
          message: AppStrings.secureConnectionFailedPleaseTryAgain,
          code: 'bad_certificate',
        );

      case DioExceptionType.transformTimeout:
        return const Failure(
          message: AppStrings.theRequestTimedOutPleaseTryAgain,
          code: 'transform_timeout',
        );

      case DioExceptionType.unknown:
        return const Failure(
          message: AppStrings.noInternetConnectionPleaseTryAgain,
          code: 'unknown',
        );
    }
  }

  static Failure _mapStatusCode(int? statusCode, dynamic data) {
    // Try to extract server message from response body.
    final serverMessage = _extractServerMessage(data);

    switch (statusCode) {
      case 400:
        return Failure(
          message: serverMessage ?? AppStrings.badRequestPleaseTryAgain,
          code: 'bad_request',
          statusCode: 400,
        );
      case 401:
        return const Failure(
          message: AppStrings.pleaseSignInAgainToContinue,
          code: 'unauthorized',
          statusCode: 401,
        );
      case 403:
        return const Failure(
          message: AppStrings.youDoNotHavePermissionToPerformThisAction,
          code: 'forbidden',
          statusCode: 403,
        );
      case 404:
        return const Failure(
          message: AppStrings.theRequestedItemCouldNotBeFound,
          code: 'not_found',
          statusCode: 404,
        );
      case 409:
        return const Failure(
          message: AppStrings.thisActionConflictsWithExistingData,
          code: 'conflict',
          statusCode: 409,
        );
      case 422:
        return Failure(
          message: serverMessage ?? AppStrings.someProvidedInformationIsInvalid,
          code: 'unprocessable_entity',
          statusCode: 422,
        );
      case 429:
        return const Failure(
          message: AppStrings.tooManyRequestsPleaseTryAgainLater,
          code: 'too_many_requests',
          statusCode: 429,
        );
      default:
        if (statusCode != null && statusCode >= 500 && statusCode < 600) {
          return Failure(
            message: AppStrings
                .theServiceIsTemporarilyUnavailablePleaseTryAgainLater,
            code: 'server_error',
            statusCode: statusCode,
          );
        }
        return Failure(
          message: AppStrings.anUnexpectedErrorOccurredPleaseTryAgain,
          code: 'unknown_status',
          statusCode: statusCode,
        );
    }
  }

  static String? _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }
}
