import 'package:mobile/core/data/api/api.dart';
import 'package:mobile/core/domain/repo/repo.dart';
import 'package:mobile/features/kyc/data/model/kyc_model.dart';

import '../../model/model.dart';

class UserKycRepoImpl extends UserKycRepo {
  final UserKycApi _kycApi;
  UserKycRepoImpl(this._kycApi);
  @override
  Future<DefaultApiResponse<String?>> getUserKycState() async {
    var res = await _kycApi.getKycState();
    return res;
  }

  @override
  Future<DefaultApiResponse<KycModel?>> getKycInfo() async {
    var res = await _kycApi.getKycInfo();
    return res;
  }
}
