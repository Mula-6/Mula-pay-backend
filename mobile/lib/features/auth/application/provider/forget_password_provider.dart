
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/application/provider/provider.dart';
import 'package:mobile/features/auth/data/model/model.dart';

import '../state/state.dart';


class ForgetPasswordProvider extends AsyncNotifier<ForgetPasswordState> {
  @override
  FutureOr<ForgetPasswordState> build() => ForgetPasswordState.initial();


  Future<void> submitNewPassword(ForgetPasswordModel model)async{
    state = AsyncLoading();
    try{
      var res = await ref.read(forgetPasswordRepoProvider).submitNewPassword(model: model);
      if(res.statusCode == 200){
        state = AsyncData(ForgetPasswordState.changed(res.message));
      }else{
        state = AsyncData(ForgetPasswordState.error(res.message)); 
      }
    }catch(e, st){
      state = AsyncError(e, st);
    }
  }

}


final forgetPasswordProvider = AsyncNotifierProvider<ForgetPasswordProvider,ForgetPasswordState >(ForgetPasswordProvider.new);