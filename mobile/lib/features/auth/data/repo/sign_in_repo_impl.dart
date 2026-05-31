import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/api/auth_api.dart';
import 'package:mobile/features/auth/data/model/access_token_model.dart';
import 'package:mobile/features/auth/data/model/sign_in_model_res.dart';

import '../../domain/repo/repo.dart';

class SignInRepoImpl extends SignInRepo {
  final AuthApi api;

  SignInRepoImpl(this.api);

  @override
  Future<DefaultApiResponse<AccessTokenModel?>> signIn(
    SignInModelRes model,
  ) async {
    var res = await api.signIn(model);
    return  res;
  }
}
