part of '../../../domain/repo/storage/storage_repo.dart';

class StorageRepoImpl extends StorageRepo {
  final SharedPreferences _preferences;
  StorageRepoImpl(this._preferences);
  @override
  Future<void> set<T>({required String key, required T value}) async {
    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      await _preferences.setString(key, jsonEncode(value));
    }
  }

  @override
  T? get<T>({required String key}) {
    var res = _preferences.get(key);

    if (res == null) return null;
    if (res is T) return res as T;

    if (res is String) {
      try {
        var decoded = jsonDecode(res) as T;
        return decoded;
      } catch (e) {
        debugPrint("error decodind due to ${e.toString()}");
      }
    }

    return null;
  }

  @override
  Future<void> delete({required String key}) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> clearStorage() async {
    await _preferences.clear();
  }
}
