import 'package:dio/dio.dart';
import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/features/auth/data/model/model.dart';

import '../../../helpers/helper.dart';

class UserWalletApi {
  final Dio _api;

  UserWalletApi(this._api);

  Future<DefaultApiResponse<WalletModel?>> getWalletInfo() async {
    try {
      var res = await _api.get("/wallet/info");
      return DefaultApiResponse.fromJson(
        res.data,
        (data) => data == null
            ? null
            : WalletModel.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }
}
