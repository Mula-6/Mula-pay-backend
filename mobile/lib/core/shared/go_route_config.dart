import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/application/state/app_auth_state.dart';
import 'package:mobile/core/shared/protected_shell_routes.dart';
import 'package:mobile/core/shared/shared.dart';
import 'package:mobile/features/auth/routes.dart';
import 'package:mobile/features/auth/ui/screens/email_otp_screen.dart';
import 'package:mobile/features/kyc/routes.dart';
import 'package:mobile/splash_screen.dart';
import '../../features/auth/data/model/model.dart';
import '../../features/onboarding/ui/screens/screens.dart';
import '../constant/constant.dart';

final mainRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    redirect: (_, state) {
      var path = state.uri.path;
      return ref
          .watch(appAuthStateProvider)
          .when(
            data: (data) => data.maybeWhen(
              error: (e) => "/auth",
              orElse: () => "/",
              hasOnboardedBefore: () => "/auth",
              hasNotOnboardedBefore: () => "/onBoarding",
              isUserNotAuthenticated: () =>
                  (path.startsWith("/auth") || (path.startsWith("/otp"))) ==
                      true
                  ? null
                  : "/auth",
              isUserAuthenticated: (dt) =>
                  (path.startsWith("/app") ||
                          path.startsWith("/kyc") ||
                          (path.startsWith("/otp"))) ==
                      true
                  ? null
                  : "/app/home",
            ),
            loading: () => "/",
            error: (e, st) => "/auth",
          );
    },
    routes: [
      GoRoute(path: "/", builder: (_, _) => WelcomeSplashScreen()),
      GoRoute(
        name: AppRoutesNames.onBoarding,
        path: "/onBoarding",
        builder: (_, _) => OnBoardingScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.otp,
        path: "/otp",
        builder: (context, state) {
          var model = state.extra as RequestOtpModel;
          return EmailOtpScreen(model: model);
        },
      ),
      authRoutes,
      shellRoutes,
      kycRoutes,
    ],
    errorBuilder: (context, _) => PageNotFoundSceen(),
  );
});
