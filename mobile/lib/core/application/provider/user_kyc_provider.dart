import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/state/user_kyc_state.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:mobile/features/kyc/data/model/kyc_model.dart';
import 'package:mobile/features/kyc/data/repo/kyc_repo_impl.dart';

import 'repo_impl_provider.dart';

class UserKycProvider extends AsyncNotifier<UserKycState> {
  @override
  FutureOr<UserKycState> build() async {
    try {
      var res = await ref.read(userKycRepoImplProvider).getUserKycState();
      var kycStatus = UserStatsChecker.kycStatusFromString(res.data);
      switch (kycStatus) {
        case null:
          return UserKycState.initial();
        case KycStatusEnum.inReview:
          return UserKycState.inReview(res.message);
        case KycStatusEnum.accepted:
          return UserKycState.accepted(res.message);
        case KycStatusEnum.rejected:
          return UserKycState.rejected(res.message);
      }
    } catch (e) {
      return UserKycState.error(e.toString());
    }
  }

  Future<KycModel?> getKycInfo() async {
    var res = await ref.read(userKycRepoImplProvider).getKycInfo();
    return res.data;
  }
}

final userKycProvider = AsyncNotifierProvider.autoDispose<UserKycProvider, UserKycState>(
  UserKycProvider.new,
);


final userKycInfoProvider = FutureProvider<KycModel?>((ref) async {
  final res = await ref.read(userKycRepoImplProvider).getKycInfo();
  return res.data;
});