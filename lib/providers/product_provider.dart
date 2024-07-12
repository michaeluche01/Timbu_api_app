import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:timbu_api_app/services/api_services.dart';

class ProductProvider with ChangeNotifier {
  Product? _products;
  bool _isLoading = false;
  final String _error = '';

  Product? get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<Product?> fetchProducts() async {
    // _isLoading = true;
    // notifyListeners();

    // Product result = await ApiService().fetchProducts();

    // _products = result;
    // notifyListeners();
    // print("omooooo ${products!.items.first.name}");
    // print("omooooo $products");

    // return products;
    try {
      _isLoading = true;
      // notifyListeners();

      // Call your API service to fetch products
      Product result = await ApiService().fetchProducts();

      // Update products and loading state
      _products = result; // Assuming result.items is a List<Product>
      _isLoading = false;

      // notifyListeners();

      // Print statements for debugging
      // print("Products: ${_products}");
      // print("Loading state: $_isLoading");
      notifyListeners();
      return _products;
    } catch (e) {
      // Handle error if fetching fails
      _isLoading = false;
      notifyListeners();
      print("Error fetching products: $e");
    }
  }
}
