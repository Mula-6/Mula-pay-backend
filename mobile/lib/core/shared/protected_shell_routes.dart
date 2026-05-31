import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/shared/shared.dart';

import 'package:mobile/features/home/routes.dart';
import 'package:mobile/features/settings/routes.dart';

import '../../features/scan/routes.dart';
import '../../features/transfer/routes.dart';

final shellRoutes = ShellRoute(
  builder: (context, state, child) {
    return MainShellWidgets(child: child);
  },
  routes: [
    GoRoute(
      name: AppRoutesNames.protectedRoutes,
      path: '/app',
      redirect: (context, state) {
        var path = state.uri.path;

        return path.startsWith("/app") ? null : "/app/home";
      },
      routes: [homeRoutes, scanRoutes, transactionRoutes, settingsRoute],
    ),
  ],
);
