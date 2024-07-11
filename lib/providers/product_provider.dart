import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:timbu_api_app/services/api_services.dart';


class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  void fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ApiService().fetchProducts();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
