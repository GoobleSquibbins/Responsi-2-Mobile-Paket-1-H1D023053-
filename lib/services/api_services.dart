import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/items.dart';
import '../constants.dart';

class ApiService {
  final String baseUrl = API_BASE_URL;

  Future<List<Items>> fetchItems(String token) async {
    final res = await http.get(
      Uri.parse('$baseUrl/items'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Items.fromJson(e)).toList();
    }
    throw Exception('Failed to load items');
  }

  Future<Items> createItem(String token, Items item) async {
    final res = await http.post(
      Uri.parse('$baseUrl/items'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json', // <-- MUST
      },
      body: jsonEncode(item.toJson()), // <-- MUST encode to JSON string
    );

    if (res.statusCode == 201) {
      return Items.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to create item: ${res.body}');
  }

  Future<Items> updateItem(String token, int id, Items item) async {
    final res = await http.put(
      Uri.parse('$baseUrl/items/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json', // <-- important
      },
      body: jsonEncode(item.toJson()), // <-- encode to JSON
    );

    if (res.statusCode == 200) {
      return Items.fromJson(json.decode(res.body));
    }

    throw Exception('Failed to update item: ${res.body}');
  }

  Future<void> deleteItem(String token, int id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/items/$id'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body); // MUST RETURN SOMETHING!
    } else {
      return {"error": "Login failed", "status": res.statusCode};
    }
  }

  Future<bool> logout(String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    return res.statusCode == 200;
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
      }),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return {"success": true};
    }

    return {
      "success": false,
      "message": json.decode(res.body)["message"] ?? "Unknown error",
    };
  }
}
