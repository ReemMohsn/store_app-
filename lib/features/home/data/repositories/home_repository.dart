import 'package:dartz/dartz.dart';
import 'package:stor_app/core/services/errors/failure.dart';
import 'package:stor_app/core/services/request_handler.dart';
import 'package:stor_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:stor_app/features/home/data/models/product_model.dart';

class HomeRepository {
  const HomeRepository(this._remote);

  final HomeRemoteDataSource _remote;

  Future<Either<Failure, List<ProductModel>>> getProducts() =>
      requestHandler(_remote.getProducts);
}
