import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

/// Holds the in-memory authentication token for the current session.
class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  /// Current DRF authentication token, or `null` when logged out.
  String? get token => _token;

  /// Whether a session token is currently active in memory.
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  /// Authenticates with [username] and [password] without storing credentials.
  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  /// Revokes the active token on the server and clears local auth state.
  Future<void> logout() async {
    final current = _token;
    if (current == null) {
      return;
    }

    try {
      await _apiClient.logout(token: current);
    } on ApiException {
      // Tetap hapus token lokal agar pengguna bisa login ulang walau server gagal merespons.
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
