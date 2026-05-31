import 'dart:async';

import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/api/auth_api.dart';
import 'package:mobile/features/auth/data/model/submit_otp_email.dart';
import 'package:mobile/features/auth/domain/repo/otp_repo.dart';

class OtpRepoImpl extends OtpRepo {
  final AuthApi api;

  OtpRepoImpl(this.api);

  @override
  Future<DefaultApiResponse<Null>> submitOtp(SubmitOtpEmail otpModel) async {
    return await api.submitOtp(otpModel);
  }


}
