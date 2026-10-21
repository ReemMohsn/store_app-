import 'package:stor_app/features/home/data/models/product_model.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess({required this.products});

  final List<ProductModel> products;
}

class HomeFailure extends HomeState {
  const HomeFailure({required this.errorMessage});

  final String errorMessage;
}
