import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/education.dart';

/// Exception thrown when an API request fails due to HTTP status, network, or JSON errors.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final int? statusCode;
  final String message;

  @override
  String toString() => statusCode != null
      ? 'ApiException($statusCode): $message'
      : 'ApiException: $message';
}

/// HTTP client for communicating with the MyPortfolio Django REST Framework API.
class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  static const Duration _timeout = Duration(seconds: 15);

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  /// Exchanges [username] and [password] for a DRF auth token at `/api/v1/auth/token/`.
  Future<String> obtainToken(String username, String password) async {
    final response = await _send(
      () => _client.post(
        _uri('/api/v1/auth/token/'),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      ),
    );

    final decoded = _decodeJson(response.body);
    if (decoded is! Map<String, dynamic> || decoded['token'] is! String) {
      throw const ApiException('Respons login dari server tidak valid.');
    }

    return decoded['token'] as String;
  }

  /// Revokes the active [token] on `/api/v1/auth/logout/`.
  Future<void> logout({required String token}) async {
    await _send(
      () => _client.post(
        _uri('/api/v1/auth/logout/'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        },
      ),
    );
  }

  /// Fetches the list of Education entries from `/api/v1/education/`.
  Future<List<Education>> getEducations() async {
    final response = await _send(
      () => _client.get(
        _uri('/api/v1/education/'),
        headers: const {'Accept': 'application/json'},
      ),
    );
    final decoded = _decodeJson(response.body);

    if (decoded is! List<dynamic>) {
      throw const ApiException(
        'Format data daftar pendidikan dari server tidak sesuai.',
      );
    }

    try {
      return decoded
          .map((item) => Education.fromJson(item as Map<String, dynamic>))
          .toList();
    } on TypeError {
      throw const ApiException(
        'Sebagian item pendidikan gagal diparsing dari JSON.',
      );
    }
  }

  /// Fetches a single Education entry by [id] from `/api/v1/education/<id>/`.
  Future<Education> getEducationDetail(int id) async {
    final response = await _send(
      () => _client.get(
        _uri('/api/v1/education/$id/'),
        headers: const {'Accept': 'application/json'},
      ),
    );
    final decoded = _decodeJson(response.body);

    if (decoded is! Map<String, dynamic>) {
      throw const ApiException(
        'Format data detail pendidikan dari server tidak sesuai.',
      );
    }

    try {
      return Education.fromJson(decoded);
    } on TypeError {
      throw const ApiException(
        'Data detail pendidikan gagal diparsing dari JSON.',
      );
    }
  }

  /// Creates a new [education] entry via `POST /api/v1/education/` using [token].
  Future<Education> createEducation(
    Education education, {
    required String token,
  }) async {
    final response = await _send(
      () => _client.post(
        _uri('/api/v1/education/'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(education.toJson()),
      ),
    );

    final decoded = _decodeJson(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const ApiException(
        'Format respons pembuatan pendidikan dari server tidak sesuai.',
      );
    }

    try {
      return Education.fromJson(decoded);
    } on TypeError {
      throw const ApiException(
        'Data pendidikan yang dibuat gagal diparsing dari JSON.',
      );
    }
  }

  Future<http.Response> _send(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(_timeout);
      _ensureSuccess(response);
      return response;
    } on TimeoutException {
      throw const ApiException(
        'Permintaan ke server melebihi batas waktu. Pastikan backend aktif.',
      );
    } on http.ClientException catch (error) {
      throw ApiException('Gagal terhubung ke server: ${error.message}');
    }
  }

  dynamic _decodeJson(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      throw const ApiException('Respons server bukan JSON yang valid.');
    }
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw ApiException(
      _extractErrorMessage(response),
      statusCode: response.statusCode,
    );
  }

  String _extractErrorMessage(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        if (decoded['detail'] is String) {
          return decoded['detail'] as String;
        }
        if (decoded['non_field_errors'] is List &&
            (decoded['non_field_errors'] as List).isNotEmpty) {
          return (decoded['non_field_errors'] as List).first.toString();
        }
        for (final entry in decoded.entries) {
          final value = entry.value;
          if (value is List && value.isNotEmpty) {
            return '${entry.key}: ${value.first}';
          }
          if (value is String && value.isNotEmpty) {
            return '${entry.key}: $value';
          }
        }
      }
    } on FormatException {
      // Abaikan body non-JSON (misal halaman error HTML Django) dan pakai status code.
    }

    return 'Permintaan gagal dengan status HTTP ${response.statusCode}.';
  }
}
