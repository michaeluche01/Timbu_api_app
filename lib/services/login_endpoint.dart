import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> login() async {
  final response = await http.post(
    Uri.parse('https://api.timbu.cloud/v2/auth/login'),
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
