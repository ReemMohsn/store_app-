import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/features/home/data/repositories/home_repository.dart';
import 'package:stor_app/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeInitial());

  final HomeRepository _repository;

  Future<void> getProducts() async {
    emit(const HomeLoading());
    final result = await _repository.getProducts();
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeFailure(errorMessage: failure.message)),
      (products) => emit(HomeSuccess(products: products)),
    );
  }
}
