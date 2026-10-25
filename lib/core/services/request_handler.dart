import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:stor_app/core/constants/app_strings.dart';
import 'package:stor_app/core/services/errors/dio_error_mapper.dart';
import 'package:stor_app/core/services/errors/failure.dart';

Future<Either<Failure, T>> requestHandler<T>(
  Future<T> Function() request,
) async {
  try {
    final data = await request();
    return Right<Failure, T>(data);
  } catch (error, stackTrace) {
    if (kDebugMode) {
      debugPrintStack(
        label: AppStrings.requestFailed(error.runtimeType),
        stackTrace: stackTrace,
      );
    }

    // Auto-detect error source and use the appropriate mapper.
    final failure = DioErrorMapper.map(error);
    return Left<Failure, T>(failure);
  }
}
