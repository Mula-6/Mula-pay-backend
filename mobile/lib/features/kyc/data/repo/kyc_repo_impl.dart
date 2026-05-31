import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/kyc/data/model/model.dart';
import 'package:mobile/features/kyc/domain/kyc_repo.dart';

import '../api/kyc_api.dart';

enum KycStatusEnum { inReview, accepted, rejected }

class KycRepoImpl extends KycRepo {
  final KycApi _api;

  KycRepoImpl(this._api);

  @override
  Future<DefaultApiResponse<Null>?> addAddress({
    required String address,
  }) async {
    var res = await _api.addAddress(model: KycModel(address: address));
    return res;
  }

  @override
  Future<DefaultApiResponse<Null>?> addBVn({required String bvn}) async {
    var res = await _api.addBVn(model: KycModel(bvn: bvn));
    return res;
  }

  @override
  Future<DefaultApiResponse<Null>?> addDateOfBirth({
    required String dob,
  }) async {
    var res = await _api.addDateOfBirth(model: KycModel(dateOfBirth: dob));
    return res;
  }

  @override
  Future<DefaultApiResponse<Null>?> addPhoneNumber({
    required String phone,
  }) async {
    var res = await _api.addPhoneNumber(model: KycModel(phone: phone));
    return res;
  }

  @override
  Future<DefaultApiResponse<Null>?> addProfileUrl({
    required String profile,
  }) async {
    var res = await _api.addProfileUrl(model: KycModel(profileUrl: profile));
    return res;
  }
  
  @override
  Future<DefaultApiResponse<Null>?> submit() async{
    var res = await _api.submit();
    return res;
  }
}
