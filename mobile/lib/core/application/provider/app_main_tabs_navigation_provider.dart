import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/app_main_tabs_navigation_state.dart';

class AppMainTabsNavigationProvider
    extends Notifier<AppMainTabsNavigationState> {
  @override
  AppMainTabsNavigationState build() => AppMainTabsNavigationState.homeScreen();

  void navigateToTransferScreen() =>
      state = AppMainTabsNavigationState.transferScreen();

  void navigateToScanScreen() =>
      state = AppMainTabsNavigationState.scanScreen();

  void navigateToSettingsScreen() =>
      state = AppMainTabsNavigationState.settingsScreen();

  void navigateToHomeScreen() =>
      state = AppMainTabsNavigationState.homeScreen();

  bool isTabActive(AppMainTabsNavigationState tab) => state == tab;
}

final appMainTabsNavigationProvider =
    NotifierProvider<AppMainTabsNavigationProvider, AppMainTabsNavigationState>(
      AppMainTabsNavigationProvider.new,
    );
