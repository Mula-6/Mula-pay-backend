import 'package:mobile/features/auth/data/model/sign_up_model.dart';

import '../../../../core/data/model/model.dart';
import '../../domain/repo/repo.dart';
import '../api/auth_api.dart';

class SignUpRepoImpl extends SignUpRepo {
  final AuthApi api;

  SignUpRepoImpl(this.api);

  @override
  Future<DefaultApiResponse<Null>> submit({required SignUpModel model}) async {
    var res = await api.signUp(model);

    return res;
  }
}
