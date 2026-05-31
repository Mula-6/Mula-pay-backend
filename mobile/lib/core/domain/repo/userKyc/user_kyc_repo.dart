import 'package:mobile/features/kyc/data/model/kyc_model.dart';

import '../../../data/model/model.dart';

abstract class UserKycRepo {
  Future<DefaultApiResponse<String?>> getUserKycState();

  Future<DefaultApiResponse<KycModel?>> getKycInfo();
}
