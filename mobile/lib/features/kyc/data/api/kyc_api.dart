import 'package:dio/dio.dart';
import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/kyc/data/model/kyc_model.dart';

import '../../../../core/helpers/helper.dart';

class KycApi {
  final Dio _api;

  KycApi(this._api);

  Future<DefaultApiResponse<Null>?> addAddress({
    required KycModel model,
  }) async {
    try {
      var res = await _api.post("kyc/address", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>?> addBVn({required KycModel model}) async {
    try {
      var res = await _api.post("kyc/bvn", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>?> addDateOfBirth({
    required KycModel model,
  }) async {
    try {
      var res = await _api.post("kyc/dob", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>?> addPhoneNumber({
    required KycModel model,
  }) async {
    try {
      var res = await _api.post("kyc/phone", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>?> addProfileUrl({
    required KycModel model,
  }) async {
    try {
      var res = await _api.post("kyc/profile-url", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<KycModel?>> kycSession() async {
    try {
      var res = await _api.get("kyc/session");
      return DefaultApiResponse.fromJson(
        res.data,
        (val) =>
            val == null ? null : KycModel.fromJson(val as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>?> submit() async {
    try {
      var res = await _api.post("kyc/submit");
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }
}
