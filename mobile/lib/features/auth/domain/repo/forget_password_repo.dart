import 'package:mobile/core/data/model/model.dart';

import '../../data/model/model.dart';

abstract class ForgetPasswordRepo {
  Future<DefaultApiResponse<Null>> submitNewPassword({
    required ForgetPasswordModel model,
  });
}
