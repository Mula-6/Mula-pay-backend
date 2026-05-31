import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';

import 'ui/screens/screens.dart';


final settingsRoute = GoRoute(
  path: "/settings",
  name: AppRoutesNames.settings,
  builder: (_, _)=> SettingsScreen(),
  routes: []);