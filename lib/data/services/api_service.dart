import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import '../../utils/constants.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(Constants.apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print("API Response: $data");
        return data.map((productJson) => Product.fromJson(productJson)).toList();
      } else {
        print("Failed to load products. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Failed to fetch products from API: $e");
      return [];
    }
  }
}
