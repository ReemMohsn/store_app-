import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/features/home/data/models/ptoduct.dart';
import 'package:stor_app/features/home/presentation/view_model/auth_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._dio) : super(ProductsInitial());
  final Dio _dio;

  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        emit(
          ProductsSuccess(
            products: (data['products'] as List<dynamic>)
                .map(ProductModel.fromJson)
                .toList(),
          ),
        );
      } else {
        emit(ProductsFailure(errorMessage: 'تعذر تحميل المنتجات (${response.statusCode})'));
      }
    } catch (_) {
      emit(ProductsFailure(errorMessage: 'تعذر الاتصال بالخادم، حاول مرة أخرى'));
    }
  }
}
