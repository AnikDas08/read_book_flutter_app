import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageServiceProvider = Provider.autoDispose<StorageService>(
  (ref) => StorageService.instance,
);

class StorageKeys {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
}

class StorageService {
  StorageService._Internal() {
    _secureStorage = const FlutterSecureStorage();
  }
  static Map<String, dynamic> _storage = {};
  static final StorageService _instance = StorageService._Internal();
  static StorageService get instance => _instance;



  late final FlutterSecureStorage _secureStorage;

  Future<void> set(String key, String value) async {
    _storage[key] = value;
     _secureStorage.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    final result = _storage[key];
    if (result != null) {
      return result;
    }
    final value = await _secureStorage.read(key: key);
    _storage[key] = value;
    return value;
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
