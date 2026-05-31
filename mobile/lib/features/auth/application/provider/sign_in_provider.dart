import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/application/provider/repo_provider.dart';
import '../../data/model/model.dart';
import '../state/state.dart';



class SignInProvider extends Notifier<SignInState> {
  @override
  SignInState build() => SignInState.initial();

  Future<void> signIn(SignInModelRes model) async {
    state = SignInState.loading();
    try {
      var res = await ref.read(signInRepoProvider).signIn(model);
      if (res.statusCode == 200) {
        state =SignInState.authenticated(res);
      } else if (res.statusCode == 401) {
        state = SignInState.inCorrectPassword(res.message);
      } else if (res.statusCode == 403) {
        state = SignInState.unVerified(res.message);
      } else if (res.statusCode == 404) {
        state = SignInState.notFound(res.message);
      } else {
        state = SignInState.error(res.message);
      }
    } catch (e) {
      state = SignInState.error(e.toString());
    }
  }
}

final signInProvider = NotifierProvider<SignInProvider, SignInState>(
  SignInProvider.new,
);
