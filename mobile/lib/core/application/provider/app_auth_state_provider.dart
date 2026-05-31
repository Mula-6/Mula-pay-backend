import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/state/app_auth_state.dart';
import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/core/domain/repo/repo.dart';
import 'package:mobile/features/auth/data/model/model.dart';
import 'repo_impl_provider.dart';

class AppAuthStateProvider extends AsyncNotifier<AppAuthState> {
  @override
  Future<AppAuthState> build() async {
    try {
      var checkOnBoading = await auth.hasOnboardedBefore();
      if (checkOnBoading == false) {
        return AppAuthState.hasNotOnboardedBefore();
      } else {
        return _refreshUserState();
      }
    } catch (e) {
      return AppAuthState.error(e.toString());
    }
  }

  Future<AppAuthState> _refreshUserState() async {
    var currentUser = await auth.getCurrentUser();
    if (currentUser.data == null) {
      return AppAuthState.isUserNotAuthenticated();
    } else {
      return AppAuthState.isUserAuthenticated(currentUser.data);
    }
  }

  void refreshCurrentUserState() async {
    AsyncLoading();
    state = AsyncData(await _refreshUserState());
  }

  UserVirtualAccount? get currentUserVirtualAccount => state.value?.whenOrNull(
    isUserAuthenticated: (user) => user?.virtualAccoutInfo,
  );

  UserBasicInFormation? get currentUser => state.value?.whenOrNull(
    isUserAuthenticated: (user) => user?.userBasicInfo,
  );

  void setKycState(String? val) {
    var current = state.value;
    if (current == null) {
      return;
    }

    state = AsyncData(
      state.when(
        data: (dt) => dt.when(
          initial: () => current,
          loading: () => current,
          error: (e) => current,
          hasOnboardedBefore: () => current,
          hasNotOnboardedBefore: () => current,
          isUserNotAuthenticated: () => current,
          isUserAuthenticated: (data) {
            var updatedUser = data?.userBasicInfo.copyWith(kycStatus: val);
            var user = data?.copyWith(userBasicInfo: updatedUser!);
            return AppAuthState.isUserAuthenticated(user);
          },
        ),
        error: (e, st) => current,
        loading: () => current,
      ),
    );
  }

  AppAuthRepo get auth => ref.read(appAuthStateRepo);

  Future<void> setHasOnBoarded() async {
    state = AsyncLoading();
    try {
      await ref.read(appAuthStateRepo).setHasOnBoarded();
      final newState = await build();
      state = AsyncData(newState);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void setIsAuthenticated(AccessTokenModel tokenModel) async {
    state = AsyncLoading();
    try {
      auth.setAccessToken(tokenModel.token);
      if (tokenModel.opaqueToken != null) {
        auth.setOpaqueToken(tokenModel.opaqueToken!);
      }

      var user = await auth.getCurrentUser();
      if (user.data == null) {
        state = AsyncData(AppAuthState.isUserNotAuthenticated());
      } else {
        state = AsyncData(AppAuthState.isUserAuthenticated(user.data));
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void deleteAccessToken() => auth.deleteAccessToken();

  Future<DefaultApiResponse> logoutUser() async {
    AsyncLoading();
    var res = await auth.logoutUser();
    if (res.successful) {
      state = AsyncData(AppAuthState.isUserNotAuthenticated());
    }
    return res;
  }
}

final appAuthStateProvider =
    AsyncNotifierProvider<AppAuthStateProvider, AppAuthState>(
      AppAuthStateProvider.new,
    );
