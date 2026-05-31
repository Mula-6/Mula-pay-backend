import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/data/api/api.dart';
import 'package:mobile/features/auth/data/api/auth_api.dart';
import 'package:mobile/features/auth/data/repo/otp_repo_impl.dart';

import '../../data/repo/forget_password_repo_impl.dart';
import '../../data/repo/sign_in_repo_impl.dart';
import '../../data/repo/sign_up_repo_impl.dart';
import '../../domain/repo/repo.dart';

final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(ref.read(dioClientProvider)),
);

final signUpRepoProvider = Provider<SignUpRepo>((ref) {
  return SignUpRepoImpl(ref.read(authApiProvider));
});

final submitOtpProvider = Provider<OtpRepo>(
  (ref) => OtpRepoImpl(ref.read(authApiProvider)),
);

final signInRepoProvider = Provider<SignInRepo>(
  (ref) => SignInRepoImpl(ref.read(authApiProvider)),
);

final forgetPasswordRepoProvider = Provider<ForgetPasswordRepo>(
  (ref) => ForgetPasswordRepoImpl(ref.read(authApiProvider)),
);
