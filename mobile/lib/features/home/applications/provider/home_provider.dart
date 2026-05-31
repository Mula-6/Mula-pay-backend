// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobile/features/home/applications/provider/repo_provider.dart';

// import '../state/state.dart';

// class HomeProvider extends Notifier<HomeState> {
//   HomeBalanceVisibility statsVisibilty;
//   HomeProvider(this.statsVisibilty);
//   @override
//   HomeState build() {
//     if (ref.read(homeProvider.notifier).balanaceVisibilityState()) {
//       statsVisibilty = HomeBalanceVisibility.show();
//     } else {
//       statsVisibilty = HomeBalanceVisibility.hide();
//     }
//     return HomeState.initial();
//   }

//   void setBalanaceVisible() => ref.read(homeRepoProvider).hideBalanceStats();

//   bool balanaceVisibilityState() =>
//       ref.read(homeRepoProvider).balanaceVisibilityState();
// }

// final homeProvider = NotifierProvider<HomeProvider, HomeState>(
//   HomeProvider.new(),
// );
