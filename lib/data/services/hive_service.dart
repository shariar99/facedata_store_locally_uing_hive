import 'package:hive/hive.dart';
import '../models/product.dart';

class HiveService {
  Future<void> saveProducts(List<Product> products) async {
    var box = await Hive.openBox<Product>('productsBox');
    await box.clear(); // Clear existing data
    await box.addAll(products); // Add new data
  }

  Future<List<Product>> getProducts() async {
    var box = await Hive.openBox<Product>('productsBox');
    return box.values.toList();
  }
}
