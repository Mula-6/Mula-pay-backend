import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/features/auth/data/model/model.dart';

abstract class AppAuthRepo {
  Future<bool> hasOnboardedBefore();
  Future<void> setHasOnBoarded();
  Future<bool> checkUserAuthenticated();

  Future<String?> getAccessToken();
  Future<String?> getOpaqueToken();

  Future<void> setOpaqueToken(String uid);
  Future<void> setAccessToken(String token);

  Future<void> resetSecureStorage();

  Future<void> deleteAccessToken();

  Future<DefaultApiResponse<CurrentUserModel?>> getCurrentUser();

  Future<DefaultApiResponse<Null>> logoutUser();

}