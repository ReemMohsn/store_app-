import 'package:stor_app/core/constants/app_strings.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? AppStrings.product}',
      description: '${json['description'] ?? ''}',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: '${json['thumbnail'] ?? json['imageUrl'] ?? ''}',
    );
  }
}
