import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/repo/storage/secure_storage_repo.dart';

class SecureStorageRepoImpl extends SecureStorageRepo {
  final FlutterSecureStorage _storage;

  SecureStorageRepoImpl(this._storage);

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> contains(String key) => _storage.containsKey(key: key);

  @override
  Future<void> delet({required String key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<T?> get<T>({required String key}) async {
    var res = await _storage.read(key: key);
    if (res == null) return null;
    return res as T;
  }

  @override
  Future<void> set<T>({required String key, required T value}) async {
    await _storage.write(key: key, value: jsonEncode(value));
  }
}
