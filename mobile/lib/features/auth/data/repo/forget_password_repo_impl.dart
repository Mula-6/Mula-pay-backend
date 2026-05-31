import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/api/auth_api.dart';
import 'package:mobile/features/auth/data/model/forget_password_model.dart';
import 'package:mobile/features/auth/domain/repo/repo.dart';

class ForgetPasswordRepoImpl extends ForgetPasswordRepo {
  final AuthApi api;

  ForgetPasswordRepoImpl(this.api);
  @override
  Future<DefaultApiResponse<Null>> submitNewPassword({
    required ForgetPasswordModel model,
  }) async {
    var res = await api.forgetPassword(model: model);
    return res;
  }
}
