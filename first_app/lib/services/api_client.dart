import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // Android emulator: 10.0.2.2
  static const String baseUrl = 'http://10.0.2.2:1337/api';

  Future<Map<String, dynamic>> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final res = await _client.get(uri);

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('GET $endpoint failed: ${res.statusCode} ${res.body}');
    }
    return json.decode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final res = await _client.post(uri, headers: {'Content-Type': 'application/json'}, body: json.encode(body));

    if (res.statusCode != 200 && res.statusCode != 201) {
      final jsonBody = json.decode(res.body);
      throw Exception(jsonBody['error']?['message'] ?? 'Unknown error');
    }

    return json.decode(res.body) as Map<String, dynamic>;
  }

  void dispose() {
    _client.close();
  }
}
