import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/model/model.dart';

abstract class SignUpRepo {
  Future<DefaultApiResponse<Null>> submit({required SignUpModel model});
}
