import 'package:stor_app/core/constants/api_end_points.dart';
import 'package:stor_app/core/services/api_service.dart';
import 'package:stor_app/features/home/data/models/product_model.dart';

class HomeRemoteDataSource {
  const HomeRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiService.get(ApiEndPoints.products);
    final data = response.data as Map<String, dynamic>;
    final products = data['products'] as List;
    return products
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
