import 'dart:convert';
import 'package:http/http.dart' as http;
import '../exceptions/app_exceptions.dart';
import 'api_endpoints.dart';

class ApiClient {
  final http.Client httpClient;

  ApiClient({http.Client? client}) : httpClient = client ?? http.Client();

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    try {
      final response = await httpClient.post(
        uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('Client error: ${e.message}');
    } catch (e) {
      throw AppException('Unexpected error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    try {
      final response = await httpClient.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('Client error: ${e.message}');
    } catch (e) {
      throw AppException('Unexpected error: ${e.toString()}');
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode == 200) {
      final jsonBody = jsonDecode(body);
      if (jsonBody is Map<String, dynamic>) {
        return jsonBody;
      } else {
        throw AppException('Invalid response format');
      }
    } else if (statusCode == 400) {
      throw BadRequestException('Bad request: ${_extractMessage(body)}');
    } else if (statusCode == 401) {
      throw AuthenticationException('Unauthorized: ${_extractMessage(body)}');
    } else if (statusCode == 403) {
      throw ForbiddenException('Forbidden: ${_extractMessage(body)}');
    } else if (statusCode == 404) {
      throw NotFoundException('Not found: ${_extractMessage(body)}');
    } else if (statusCode >= 500 && statusCode < 600) {
      throw ServerException('Server error ($statusCode): ${_extractMessage(body)}');
    } else {
      throw AppException('Unexpected error ($statusCode): ${_extractMessage(body)}');
    }
  }

  String _extractMessage(String responseBody) {
    try {
      final jsonBody = jsonDecode(responseBody);
      if (jsonBody is Map<String, dynamic> && jsonBody.containsKey('message')) {
        return jsonBody['message'].toString();
      }
      return responseBody;
    } catch (_) {
      return responseBody;
    }
  }
}
