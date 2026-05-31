import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';

import 'ui/screens/screens.dart';

final authRoutes = GoRoute(
  path: "/auth",
  name: AppRoutesNames.login,
  builder: (context, _) => SignInScreen(),
  routes: [
    GoRoute(
      name: AppRoutesNames.forgetPassword,
      path: "forget-password",
      builder: (context, _) => ForgetPasswordScreen(),
    ),
    GoRoute(
      name: AppRoutesNames.newPassword,
      path: "new-password", builder: (context, state){
        var token = state.extra as String;
        return  EnterForgetPasswordScreen(token: token);
      }),
    GoRoute(
      name: AppRoutesNames.register,
      path: "create", builder: (context, _) => SignUpScreen()),
  ],
);
