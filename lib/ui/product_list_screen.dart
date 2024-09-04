import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/product.dart';
import '../data/repositories/product_repository.dart';
import 'widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  final ProductRepository _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _repository.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ProductItem(product: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
