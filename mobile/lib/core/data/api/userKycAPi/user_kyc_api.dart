
import 'package:dio/dio.dart';
import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/kyc/data/model/kyc_model.dart';

import '../../../helpers/helper.dart';

class UserKycApi {
  final Dio _api;

  UserKycApi(this._api);

  Future<DefaultApiResponse<String?>> getKycState() async {
    try {
      var res = await _api.get("/kyc/kyc-state");
      return DefaultApiResponse.fromJson(
        res.data,
        (data) => data == null ? null : data as String,
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<KycModel?>> getKycInfo() async {
    try {
      var res = await _api.get("/kyc/kyc-info");
      return DefaultApiResponse.fromJson(
        res.data,
        (data) => data == null
            ? null
            : KycModel.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }
}
