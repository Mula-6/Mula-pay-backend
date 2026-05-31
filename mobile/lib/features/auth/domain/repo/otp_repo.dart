import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/model/submit_otp_email.dart';

abstract class OtpRepo {
  Future<DefaultApiResponse<Null>> submitOtp (SubmitOtpEmail otpModel);

}