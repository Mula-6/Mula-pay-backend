
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_main_tabs_navigation_state.freezed.dart';


@freezed  
sealed class AppMainTabsNavigationState  with _$AppMainTabsNavigationState {
  const factory  AppMainTabsNavigationState.homeScreen() = _HomeScreen;
  const factory  AppMainTabsNavigationState.transferScreen() = _TransferScreen;
  const factory  AppMainTabsNavigationState.scanScreen() = _ScanScreen;
  const factory  AppMainTabsNavigationState.settingsScreen() = _SettingsScreen;
}