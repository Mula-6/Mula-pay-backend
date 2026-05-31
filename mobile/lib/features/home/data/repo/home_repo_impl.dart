import 'package:mobile/core/domain/repo/storage/storage_repo.dart';

import '../../../../core/constant/text.dart';
import '../../domain/repo/repo.dart';

class HomeRepoImpl  extends HomeRepo{
  final StorageRepo _appStorage;

  HomeRepoImpl(this._appStorage);
  @override
  Future<void> saveVisibilityBalanceState(bool value) async{
    await _appStorage.set<bool>(key: hideBalanceKey, value: value);
  }
  
  @override
  bool balanaceVisibilityState(){
    return  _appStorage.get<bool>(key: hideBalanceKey) ?? false;
  }


}