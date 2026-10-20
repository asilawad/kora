import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Storage keys used by the app.
abstract final class StorageKeys {
  static const String authToken = 'auth_token';
}

/// Contract for persisting the customer's bearer token.
abstract interface class TokenStorage {
  Future<String?> read();

  Future<void> save(String token);

  Future<void> clear();
}

/// [TokenStorage] backed by `flutter_secure_storage`.
final class SecureTokenStorage implements TokenStorage {
  const SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() => _storage.read(key: StorageKeys.authToken);

  @override
  Future<void> save(String token) =>
      _storage.write(key: StorageKeys.authToken, value: token);

  @override
  Future<void> clear() => _storage.delete(key: StorageKeys.authToken);
}
