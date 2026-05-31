import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/application/provider/repo_provider.dart';
import '../../data/model/model.dart';
import '../state/state.dart';

class SignUpProvider extends AsyncNotifier<SignUpState> {
  @override
  SignUpState build() {
    return SignUpState.initial();
  }

  Future<void> onSubmit(SignUpModel model) async {
    state = AsyncLoading();

    try {
      var res = await ref.read(signUpRepoProvider).submit(model: model);
      if (res.successful) {
        state = AsyncData(SignUpState.created(res.message));
      } else if(res.statusCode == 403){
        state = AsyncData(SignUpState.unverified(res.message));
      }
      else if (res.statusCode == 400) {
        state = AsyncData(SignUpState.exist(res.message));
      } else {
        state = AsyncData(SignUpState.error(res.message));
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpProvider, SignUpState>(
  SignUpProvider.new,
);
