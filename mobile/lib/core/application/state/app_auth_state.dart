import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/auth/data/model/model.dart';
part 'app_auth_state.freezed.dart';

@freezed
sealed class AppAuthState with _$AppAuthState {
  const factory AppAuthState.initial() = _Initial;
  const factory AppAuthState.loading() = _Loading;
  const factory AppAuthState.error(String e) = _Error;
  const factory AppAuthState.hasOnboardedBefore() = _HasOnBoardedBefore;
  const factory AppAuthState.hasNotOnboardedBefore() = _HasNotOnBoardedBefore;
  const factory AppAuthState.isUserNotAuthenticated() = _IsUserNotAuthenticated;
  const factory AppAuthState.isUserAuthenticated(CurrentUserModel? user) = _IsUserAuthenticated;
}
