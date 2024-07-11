import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timbu_api_app/models/product.dart';

class ApiService {
  static const String baseUrl = 'https://api.timbu.cloud/products';
  static const String apiKey =
      'ade3a017aae344c5b3f2fc32598cfd6e20240708233703962021';
  static const String appId = 'KAE9RX3DMKYJ95D';
  static const String organizationId = '698268b2479143839f836826adb7a803';

  Future<String> login() async {
    final response = await http.post(
      Uri.parse('https://api.timbu.cloud/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': 'michaelcee2000@gmail.com',
        'password': 'Mike12345',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  Future <List<Product>> fetchProducts() async {
    final String accessToken = await login();
    const url =
        '$baseUrl?organization_id=$organizationId&reverse_sort=false&page=1&size=25&Appid=$appId&Apikey=$apiKey';
    // const url =
    //     '$baseUrl?organization_id=$organizationId&reverse_sort=false&page=1&size=25&appId=$appId&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Response recieved: ${response.body}');
      List<dynamic> data = json.decode(response.body)['items'];
      return data.map((items) => Product.fromJson(items)).toList();
    } else {
      print('Failed to load products: ${response.statusCode}');
      throw Exception('Failed to load products');
    }
  }
}
//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(
//       Uri.parse(baseUrl),
//       headers: {
//         'Authorization': 'Bearer $apiKey',
//       },
//     );

//     if (response.statusCode == 200) {
//       print('Response recieved: ${response.body}');
//       List<dynamic> data = json.decode(response.body)['data'];
//       return data.map((product) => Product.fromJson(product)).toList();
//     } else {
//       print('Failed to load products: ${response.statusCode}');
//       throw Exception('Failed to load products');
//     }
//   }
// }


// curl -H "Authorization: Bearer  ade3a017aae344c5b3f2fc32598cfd6e20240708233703962021" -H "Accept: application/json" https://api.timbu.cloud/products

