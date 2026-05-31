import 'package:dio/dio.dart';
import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/model/model.dart';
import 'package:mobile/features/auth/data/model/submit_otp_email.dart';

import '../../../../core/helpers/helper.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<DefaultApiResponse<Null>> signUp(SignUpModel model) async {
    try {
      var res = await dio.post("/auth/create", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<EmailRegOtp?>> requestEmailRegOtp({
    required RequestOtpModel model,
  }) async {
    try {
      final res = await dio.post("/auth/reg-otp", data: model.toJson());
      return DefaultApiResponse.fromJson(
        res.data,
        (val) => val == null
            ? null
            : EmailRegOtp.fromJson(val as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>> submitOtp(SubmitOtpEmail otpModel) async {
    try {
      var res = await dio.post("/auth/otp-verify", data: otpModel.toJson());
      return DefaultApiResponse.fromJson(res.data, (val) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<AccessTokenModel?>> signIn(
    SignInModelRes signModel,
  ) async {
    try {
      var res = await dio.post(
        "/auth/access-account",
        data: signModel.toJson(),
        options: Options(extra: {"form": true}),
      );
      return DefaultApiResponse.fromJson(
        res.data,
        (val) => val == null
            ? null
            : AccessTokenModel.fromJson(val as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>> forgetPassword({required ForgetPasswordModel model}) async {
    try{
      var res = await dio.post("/auth/forget-password", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (val)=> null);
    }on DioException catch(e){
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }
}
