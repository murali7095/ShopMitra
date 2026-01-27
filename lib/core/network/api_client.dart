import 'dart:convert';
import 'package:http/http.dart' as http;
import '../exceptions/app_exceptions.dart';
import 'api_endpoints.dart';

class ApiClient {
  final http.Client httpClient;

  ApiClient({http.Client? client}) : httpClient = client ?? http.Client();

  Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> data,
      ) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    try {
      final response = await httpClient.post(
        uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      return _processResponse(response);
    } on AppException {
      rethrow;
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } catch (e) {
      throw AppException('Unexpected error: $e');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    try {
      final response = await httpClient.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      return _processResponse(response);
    } on AppException {
      rethrow;
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } catch (e) {
      throw AppException('Unexpected error: $e');
    }
  }

  http.Response _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      return response;
    }

    final message = _extractMessage(body);

    switch (statusCode) {
      case 400:
        throw BadRequestException(message);
      case 401:
        throw AuthenticationException(message);
      case 403:
        throw ForbiddenException(message);
      case 404:
        throw NotFoundException(message);
      default:
        if (statusCode >= 500) {
          throw ServerException(message);
        }
        throw AppException('Unexpected error ($statusCode): $message');
    }
  }

  String _extractMessage(String responseBody) {
    try {
      final jsonBody = jsonDecode(responseBody);
      if (jsonBody is Map<String, dynamic> &&
          jsonBody.containsKey('message')) {
        return jsonBody['message'].toString();
      }
      return responseBody;
    } catch (_) {
      return responseBody;
    }
  }
}
