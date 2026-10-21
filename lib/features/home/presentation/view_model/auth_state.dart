import 'package:stor_app/features/home/data/models/ptoduct.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  ProductsSuccess({required this.products});

  final List<ProductModel> products;
}

class ProductsFailure extends ProductsState {
  ProductsFailure({required this.errorMessage});

  final String errorMessage;
}
