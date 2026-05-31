import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/core/data/repo/storage/secure_storage_repo_impl.dart';
import 'package:mobile/core/domain/repo/storage/secure_storage_repo.dart';
import 'package:mobile/core/domain/repo/storage/storage_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  throw UnimplementedError();
});

final appSecureStorageProvider = Provider<SecureStorageRepo>((ref) {
  return SecureStorageRepoImpl(ref.read(flutterSecureStorageProvider));
});

final appStorageProvider = Provider<StorageRepo>((ref) {
  return StorageRepoImpl(ref.read(sharedPreferenceProvider));
});
