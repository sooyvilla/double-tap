import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageConfig {
  static final SecureStorageConfig _instance = SecureStorageConfig._internal();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  factory SecureStorageConfig() {
    return _instance;
  }

  SecureStorageConfig._internal();

  Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
