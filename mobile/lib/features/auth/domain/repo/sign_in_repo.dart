import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/features/auth/data/model/model.dart';

abstract class SignInRepo {
  Future<DefaultApiResponse<AccessTokenModel?>> signIn(SignInModelRes model);
}
