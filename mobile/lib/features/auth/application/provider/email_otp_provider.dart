import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/application/provider/provider.dart';
import 'package:mobile/features/auth/data/model/model.dart';
import 'package:mobile/features/auth/data/model/submit_otp_email.dart';

import '../state/state.dart';

class EmailOtpProvider extends Notifier<EmailOtpState> {
  @override
  EmailOtpState build() {
    return EmailOtpState.initial();
  }

 void requestOtp({required RequestOtpModel model}) async {
  state = EmailOtpState.loading();
  
    try {
      var res = await ref
          .read(authApiProvider)
          .requestEmailRegOtp(model: model);
      
      state = 
        res.statusCode == 200 
          ? EmailOtpState.requestOtp(res)
          : res.statusCode == 429
            ? EmailOtpState.maxRetry(res.message)
            : EmailOtpState.unVerified(res.message);
      
    } catch (e) {
      state = EmailOtpState.error(e.toString());
    }
  }

  void submitOtp({required SubmitOtpEmail otpModel}) async {
    state = EmailOtpState.loading();
    try {
      var res = await ref.read(submitOtpProvider).submitOtp(otpModel);
      state =
        res.statusCode == 200
            ? EmailOtpState.verified(res.message)
            : res.statusCode == 429
            ? EmailOtpState.maxRetry(res.message)
            : EmailOtpState.unVerified(res.message);
    
    } catch (e) {
      state = EmailOtpState.error(e.toString());
    }
  }
}

final emailOtpProvider = NotifierProvider<EmailOtpProvider, EmailOtpState>(
  EmailOtpProvider.new,
);
