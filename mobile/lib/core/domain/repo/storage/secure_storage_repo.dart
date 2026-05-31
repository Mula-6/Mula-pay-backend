abstract class SecureStorageRepo {
  Future<T?> get<T>({required String key});
  Future<void> set<T>({required String key, required T value});

  Future<void> delet({required String key});

  Future<void> clear();
  Future<bool> contains(String key);
}
