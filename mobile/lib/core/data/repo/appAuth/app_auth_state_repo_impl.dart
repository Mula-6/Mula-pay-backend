import 'package:mobile/core/data/api/api.dart';
import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/core/domain/repo/repo.dart';
import 'package:mobile/features/auth/data/model/model.dart';

import '../../../constant/text.dart';

class AppAuthStateRepoImpl extends AppAuthRepo {
  final StorageRepo _repo;
  final SecureStorageRepo _sRepo;
  final AppAuthStateApi _authStateApi;

  AppAuthStateRepoImpl(this._repo, this._sRepo, this._authStateApi);
  @override
  Future<bool> hasOnboardedBefore() async {
    return await _repo.get(key: hasOnBoardedKey) ?? false;
  }

  @override
  Future<void> setHasOnBoarded() async {
    await _repo.set(key: hasOnBoardedKey, value: true);
  }

  @override
  Future<bool> checkUserAuthenticated() async {
    return await _sRepo.get(key: isAuthenticated) ?? false;
  }

  @override
  Future<String?> getAccessToken() {
    return _sRepo.get<String>(key: aceessTokenKey);
  }

  @override
  Future<String?> getOpaqueToken() async {
    return _sRepo.get(key: opaqueTokenKey);
  }

  @override
  Future<void> setOpaqueToken(String uid) async {
    await _sRepo.set(key: opaqueTokenKey, value: uid.replaceAll('"', ''));
  }

  @override
  Future<void> setAccessToken(String token) async {
    await _sRepo.set(key: aceessTokenKey, value: token.replaceAll('"', ''));
  }

  @override
  Future<void> resetSecureStorage() async {
    await _sRepo.clear();
  }

  @override
  Future<DefaultApiResponse<CurrentUserModel?>> getCurrentUser() async {
    var res = await _authStateApi.getCurrentUser();
    return res;
  }

  @override
  Future<void> deleteAccessToken() async {
    await _sRepo.delet(key: aceessTokenKey);
  }

  @override
  Future<DefaultApiResponse<Null>> logoutUser() async {
    var token = await getOpaqueToken() ?? "";

    var fromattedOpaqueToken = token.replaceAll('"', '');

    var res = await _authStateApi.logoutUser(
      model: OpaqueOkenModel(token: fromattedOpaqueToken),
    );
    if (res.successful) {
      await resetSecureStorage();
    }
    return res;
  }
}
