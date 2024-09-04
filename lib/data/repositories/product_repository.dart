import 'dart:io';

import 'package:ecommeres/data/services/api_service.dart';

import '../models/product.dart';
import '../services/hive_service.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();
  final HiveService _hiveService = HiveService();

  Future<List<Product>> getProducts() async {
    List<Product> products = await _hiveService.getProducts();
    print("Loaded ${products.length} products from Hive");

    if (await _isConnected()) {
      try {
        List<Product> remoteProducts = await _apiService.fetchProducts();
        if (remoteProducts.isNotEmpty && !_areProductsSame(products, remoteProducts)) {
          await _hiveService.saveProducts(remoteProducts);
          products = remoteProducts;
          print("Loaded ${products.length} products from API and saved to Hive");
        }
      } catch (e) {
        print('Error fetching data from API, using local data: $e');
      }
    } else {
      print('No internet connection. Using local data.');
    }

    return products;
  }

  Future<bool> _isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  bool _areProductsSame(List<Product> local, List<Product> remote) {
    if (local.length != remote.length) return false;
    for (int i = 0; i < local.length; i++) {
      if (local[i].id != remote[i].id) return false;
    }
    return true;
  }
}
