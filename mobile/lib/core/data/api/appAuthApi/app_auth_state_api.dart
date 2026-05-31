import 'package:dio/dio.dart';
import 'package:mobile/core/helpers/default_res_return.dart';
import 'package:mobile/features/auth/data/model/current_user_model.dart';

import '../../../../features/auth/data/model/model.dart';
import '../../model/model.dart';

class AppAuthStateApi {
  final Dio _api;
  AppAuthStateApi(this._api);

  Future<DefaultApiResponse<CurrentUserModel?>> getCurrentUser() async {
    try {
      var res = await _api.get("/users/current-user");
      return DefaultApiResponse.fromJson(
        res.data,
        (data) => data == null
            ? null
            : CurrentUserModel.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }

  Future<DefaultApiResponse<Null>> logoutUser({required OpaqueOkenModel model}) async {
    try {
      var res = await _api.delete("/auth/logout", data: model.toJson());
      return DefaultApiResponse.fromJson(res.data, (data) => null);
    } on DioException catch (e) {
      return DefaultResReturn.exception<Null>(e, data: null);
    }
  }
}
