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

  factory ProductModel.fromJson(Object? source) {
    final json = source as Map<String, dynamic>;
    return ProductModel(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? 'منتج'}',
      description: '${json['description'] ?? ''}',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: '${json['thumbnail'] ?? json['imageUrl'] ?? ''}',
    );
  }
}
