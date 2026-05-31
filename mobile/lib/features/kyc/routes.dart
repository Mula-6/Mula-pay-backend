import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';

import 'ui/screens/screens.dart';

final kycRoutes = GoRoute(
  name: AppRoutesNames.kyc,
  path: "/kyc",
  builder: (context, state) => KycHomeScreen(),
  routes: [
    GoRoute(
      path: "/bvn",
      name: AppRoutesNames.bvn,
      builder: (context, state) {
        var initialBvn = state.extra != null ? state.extra as String : "";
        return KycBvnScreen(initialBvn: initialBvn);
      },
    ),

    GoRoute(
      path: "/address",
      name: AppRoutesNames.kycAddress,
      builder: (context, state) {
        var initialAddress = state.extra != null ? state.extra as String : "";
        return KycAddressScreen(initialAddress: initialAddress);
      },
    ),

    GoRoute(
      path: "/face-reg",
      name: AppRoutesNames.faceReg,
      builder: (context, state) {
        var profileUrl = state.extra != null ? state.extra as String : null;
        return KycFaceRec(profileUrl: profileUrl);
      },
    ),
    GoRoute(
      path: "/date-of-birth",
      name: AppRoutesNames.kycDob,
      builder: (context, state) {
        var dob = state.extra != null ? state.extra as String : "";
        return KycDateOfBirth(dob: dob);
      },
    ),
    GoRoute(
      path: "/phone",
      name: AppRoutesNames.kycPhoneNumber,
      builder: (context, state) {
        var initialPhone = state.extra != null ? state.extra as String : "";
        return KycPhoneNumber(initialPhone: initialPhone);
      },
    ),

    GoRoute(
      path: "/kyc-status",
      name: AppRoutesNames.kycStatus,
      builder: (context, state) {
        return KycStatusScreen();
      },
    ),
  ],
);
