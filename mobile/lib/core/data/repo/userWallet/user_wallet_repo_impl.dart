import 'package:mobile/core/data/api/api.dart';
import 'package:mobile/core/data/model/default_api_response.dart';
import 'package:mobile/core/domain/repo/repo.dart';
import 'package:mobile/features/auth/data/model/wallet_model.dart';

class UserWalletRepoImpl extends UserWalletRepo {
  final UserWalletApi _userWalletApi;

  UserWalletRepoImpl(this._userWalletApi);

  @override
  Future<DefaultApiResponse<WalletModel?>> getWalletInfo() async {
    var res = await _userWalletApi.getWalletInfo();
    return res;
  }
}
