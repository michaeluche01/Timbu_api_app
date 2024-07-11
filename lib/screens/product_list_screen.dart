import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_api_app/models/product.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _productProvider = ProductProvider();
  @override
  void initState() {
    super.initState();
    _productProvider.fetchProducts();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timbu Products'),
      ),
      body: _buildProductList(),
    );
  }

  Widget _buildProductList() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.products.isEmpty) {
          return const Center(child: Text('No products found'));
        } else {
          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];
              final item = product.items[0];
              return _buildProductItem(item);
            },
          );
        }
      },
    );
  }

  Widget _buildProductItem(Item product) {
    final imageUrl = product.productImage.isNotEmpty ? product.productImage[0] : '';

    final price = product.currentPrice.isNotEmpty ? product.currentPrice[0].prices['price'] : 'N/A';

    return ListTile(
      leading: imageUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 60.0,
                height: 60.0,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              ),
            )
          : const Icon(Icons.image_not_supported),
      title: Text(product.name),
      subtitle: Text(
        'Price: $price\nAvailability: ${product.isAvailable ? 'Available' : 'Unavailable'}',
      ),
    );
  }
}
