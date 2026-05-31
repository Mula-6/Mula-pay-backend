import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/data/api/api.dart';
import 'package:mobile/core/data/repo/userKyc/user_kyc_repo_impl.dart';
import 'package:mobile/core/data/repo/userWallet/user_wallet_repo_impl.dart';
import 'package:mobile/core/domain/repo/appAuth/app_auth_repo.dart';
import 'package:mobile/core/domain/repo/repo.dart';
import 'package:mobile/core/domain/repo/userKyc/user_kyc_repo.dart';

import '../../data/repo/appAuth/app_auth_state_repo_impl.dart';



final appAuthStateApiProvider = Provider<AppAuthStateApi>(
  (ref) => AppAuthStateApi(ref.read(dioClientProvider)),
);

final appAuthStateRepo = Provider<AppAuthRepo>(
  (ref) => AppAuthStateRepoImpl(
    ref.read(appStorageProvider),
    ref.read(appSecureStorageProvider),
    ref.read(appAuthStateApiProvider),
  ),
);

final userKycApiProvider = Provider<UserKycApi>(
  (ref) => UserKycApi(ref.read(dioClientProvider)),
);

final userKycRepoImplProvider = Provider<UserKycRepo>(
  (ref) => UserKycRepoImpl(ref.read(userKycApiProvider)),
);

final userWalletApiProvider = Provider<UserWalletApi>(
  (ref) => UserWalletApi(ref.read(dioClientProvider)),
);

final userWalletRepoImplProvider = Provider<UserWalletRepo>(
  (ref) => UserWalletRepoImpl(ref.read(userWalletApiProvider)),
);
