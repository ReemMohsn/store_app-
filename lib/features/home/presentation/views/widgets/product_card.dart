import 'package:flutter/material.dart';
import 'package:stor_app/core/themes/app_color.dart';
import 'package:stor_app/features/home/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox.expand(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: AppColor.imagePlaceholder,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 42,
                    color: AppColor.iconSecondary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
