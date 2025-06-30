import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GenericApiService<T> {
  final T Function(Map<String, dynamic>) fromJson;
  final String baseUrl;
  final Map<String, String>? defaultHeaders;

  GenericApiService({
    required this.fromJson,
    required this.baseUrl,
    this.defaultHeaders,
  });

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    ...?defaultHeaders,
  };

  Future<List<T>> fetchAll() async {
    try {
      print('🔄 Attempting to fetch from: $baseUrl/');
      print('📡 Headers: $_headers');

      final response = await http.get(
        Uri.parse('$baseUrl/'),
        headers: _headers,
      ).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout - Check if server is running');
        },
      );

      print('✅ Response received');
      print('📊 Status Code: ${response.statusCode}');
      print('📋 Response Headers: ${response.headers}');
      print('📄 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          print('⚠️  Empty response body');
          return [];
        }

        final responseBody = jsonDecode(response.body);
        print('🔍 Parsed JSON type: ${responseBody.runtimeType}');

        // Handle both direct array and paginated responses
        List<dynamic> jsonList;
        if (responseBody is List) {
          jsonList = responseBody;
          print('📝 Direct array with ${jsonList.length} items');
        } else if (responseBody is Map && responseBody.containsKey('results')) {
          // Django REST framework pagination
          jsonList = responseBody['results'];
          print('📝 Paginated response with ${jsonList.length} items');
        } else if (responseBody is Map && responseBody.containsKey('data')) {
          // Common API response format
          jsonList = responseBody['data'];
          print('📝 Data wrapper with ${jsonList.length} items');
        } else {
          print('❌ Unexpected response format: $responseBody');
          throw Exception('Unexpected response format: Expected List or Object with results/data key');
        }

        print('🔄 Converting ${jsonList.length} items to objects...');
        final result = jsonList.map((json) {
          print('🔧 Converting item: $json');
          return fromJson(json);
        }).toList();

        print('✅ Successfully converted ${result.length} items');
        return result;

      } else {
        final errorMsg = 'HTTP ${response.statusCode}: ${response.body}';
        print('❌ HTTP Error: $errorMsg');
        throw Exception(errorMsg);
      }
    } on SocketException catch (e) {
      final errorMsg = 'Network error - Check internet connection and server: $e';
      print('🌐 $errorMsg');
      throw Exception(errorMsg);
    } on FormatException catch (e) {
      final errorMsg = 'Invalid JSON response: $e';
      print('📄 $errorMsg');
      throw Exception(errorMsg);
    } catch (e) {
      final errorMsg = 'Unexpected error: $e';
      print('❌ $errorMsg');
      throw Exception(errorMsg);
    }
  }

  Future<T?> fetchSingle(String id) async {
    try {
      print('🔄 Fetching single item from: $baseUrl/$id/');
      final response = await http.get(
        Uri.parse('$baseUrl/$id/'),
        headers: _headers,
      ).timeout(Duration(seconds: 10));

      print('📊 Status: ${response.statusCode}');
      print('📄 Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        return fromJson(jsonMap);
      } else {
        throw Exception('Failed to load item: ${response.statusCode} - ${response.body}');
      }
    } on SocketException catch (e) {
      print('🌐 Network error: $e');
      throw Exception('Network error - Check connection: $e');
    } catch (e) {
      print('❌ Error fetching item: $e');
      throw Exception('Error fetching item: $e');
    }
  }

  Future<T?> create(Map<String, dynamic> data) async {
    try {
      print('🔄 Creating item at: $baseUrl/');
      print('📤 Data: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse('$baseUrl/'),
        headers: _headers,
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 10));

      print('📊 Create Status: ${response.statusCode}');
      print('📄 Create Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        return fromJson(jsonMap);
      } else {
        throw Exception('Failed to create: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('❌ Error creating: $e');
      throw Exception('Error creating item: $e');
    }
  }

  Future<T?> update(String id, Map<String, dynamic> data) async {
    try {
      print('🔄 Updating item at: $baseUrl/$id/');
      final response = await http.put(
        Uri.parse('$baseUrl/$id/'),
        headers: _headers,
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 10));

      print('📊 Update Status: ${response.statusCode}');
      print('📄 Update Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        return fromJson(jsonMap);
      } else {
        throw Exception('Failed to update: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('❌ Error updating: $e');
      throw Exception('Error updating item: $e');
    }
  }

  Future<bool> delete(String id) async {
    try {
      print('🔄 Deleting item at: $baseUrl/$id/');
      final response = await http.delete(
        Uri.parse('$baseUrl/$id/'),
        headers: _headers,
      ).timeout(Duration(seconds: 10));

      print('📊 Delete Status: ${response.statusCode}');
      return response.statusCode == 204 || response.statusCode == 200;
    } catch (e) {
      print('❌ Error deleting: $e');
      return false;
    }
  }
}