import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/features/kyc/application/provider/repo_provider.dart';
import 'package:mobile/features/kyc/application/state/kyc_submittion_state.dart';

class KycSubmtionProvider extends AsyncNotifier<KycSubmittionState> {
  @override
  FutureOr<KycSubmittionState> build() async => refreshState();

  Future<DefaultApiResponse?> addBvn({required String bvn}) async {
    var res = await ref.read(kycRepoProviderImpl).addBVn(bvn: bvn);

    if (res!.successful) {
      AsyncLoading();
      state = AsyncData(await refreshState(showMessage: false));
    }

    return res;
  }

  Future<DefaultApiResponse?> addAddress({required String address}) async {
    var res = await ref.read(kycRepoProviderImpl).addAddress(address: address);

    if (res!.successful) {
      AsyncLoading();
      state = AsyncData(await refreshState(showMessage: false));
    }

    return res;
  }

  Future<DefaultApiResponse?> addProfileUrl({required String url}) async {
    var res = await ref.read(kycRepoProviderImpl).addProfileUrl(profile: url);

    if (res!.successful) {
      AsyncLoading();
      state = AsyncData(await refreshState(showMessage: false));
    }

    return res;
  }

  Future<DefaultApiResponse?> addDob({required String dob}) async {
    var res = await ref.read(kycRepoProviderImpl).addDateOfBirth(dob: dob);

    if (res!.successful) {
      AsyncLoading();
      state = AsyncData(await refreshState(showMessage: false));
    }

    return res;
  }

  Future<DefaultApiResponse?> addPhone({required String phone}) async {
    var res = await ref.read(kycRepoProviderImpl).addPhoneNumber(phone: phone);

    if (res!.successful) {
      AsyncLoading();
      state = AsyncData(await refreshState(showMessage: false));
    }

    return res;
  }

  Future<KycSubmittionState> refreshState({bool showMessage = true}) async {
    var res = await ref.read(kycApiProvider).kycSession();
    return res.data == null
        ? KycSubmittionState.initial(res.message)
        : showMessage
        ? KycSubmittionState.formNotCompleted(model: res.data, message: res.message)
        : KycSubmittionState.formNotCompleted(model: res.data);
  }

  void sumbmit() async {
    AsyncLoading();
    var res = await ref.read(kycApiProvider).submit();
    if (res!.successful) {
      state = AsyncData(KycSubmittionState.formCompleted(res.message));
    }else{
      state = AsyncData(KycSubmittionState.error(res.message));
    }
  }
}

final kycSubmtionProvider = AsyncNotifierProvider.autoDispose<KycSubmtionProvider, KycSubmittionState>(
  KycSubmtionProvider.new,
);
