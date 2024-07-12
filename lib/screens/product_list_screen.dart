import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timbu_api_app/models/product.dart';
import 'package:timbu_api_app/providers/constants.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 5.0),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('lib/images/male-avatar.png'),
                      radius: 18.0,
                    ),
                    const SizedBox(width: 15.0),
                    SizedBox(
                      child: Text(
                        'Welcome $kuser1',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_active,
                          color: Colors.red[400],
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.red[400],
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Gadget List ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SizedBox(
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    return FutureBuilder(
                        future: provider
                            .fetchProducts(), 
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // Access products from snapshot.data (assuming it holds the data)
                            final products = snapshot.data;

                            return ListView.builder(
                              itemCount: products!.items.length,
                              itemBuilder: (context, index) {
                                final product = products.items[index];
                                return _buildProductItem(
                                    product); // No need to call provider
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 

  Widget _buildProductItem(Item product) {
    String formatPrice(double price) {
      final formatter = NumberFormat('#,##0');
      return formatter.format(price.toInt());
    }

    // String imgUrl =
    //     "$kimgurl/${product.photos.first.url}?organization_id=$korganizationId&Appid=$kappId&Apikey=$kapiKey";

    // print(imgUrl);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 8.0), 
      leading: product.photos.isNotEmpty
          ? SizedBox(
              width: 56.0, 
              height: 56.0, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "$kimgurl/${product.photos.first.url}?organization_id=$korganizationId&Appid=$kappId&Apikey=$kapiKey",
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            )
          : Container(
              child: const Text('1'),
            ),
      title: Text(product.name),
      subtitle: Text(
        'Price: ₦${product.currentPrice.isNotEmpty ? formatPrice(product.currentPrice.first.prices['NGN'][0]) : 'N/A'} \nAvailability: ${product.isAvailable ? 'Available' : 'Unavailable'}',
      ),
    );
  }
}
