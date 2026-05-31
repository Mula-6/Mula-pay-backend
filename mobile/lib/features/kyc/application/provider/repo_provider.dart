import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/data/api/dioClient/dio_client.dart';
import 'package:mobile/features/kyc/data/api/kyc_api.dart';
import 'package:mobile/features/kyc/domain/kyc_repo.dart';

import '../../data/repo/kyc_repo_impl.dart';

final kycApiProvider = Provider<KycApi>(
  (ref) => KycApi(ref.read(dioClientProvider)),
);
final kycRepoProviderImpl = Provider<KycRepo>(
  (ref) => KycRepoImpl(ref.read(kycApiProvider)),
);
