import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(product.title),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
    );
  }
}
