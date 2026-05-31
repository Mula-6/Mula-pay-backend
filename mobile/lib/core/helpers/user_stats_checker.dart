import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../features/kyc/data/repo/kyc_repo_impl.dart';
import '../application/provider/provider.dart';
import '../shared/shared.dart';

class UserStatsChecker {
  static void init(WidgetRef ref, BuildContext context) async {
    await UserStatsChecker._checkCameraPermission();
    // ignore: use_build_context_synchronously
    UserStatsChecker._checkKycStats(ref, context);
  }

  static KycStatusEnum? kycStatusFromString(String? status) {
    switch (status) {
      case 'in_review':
        return KycStatusEnum.inReview;
      case 'accepted':
        return KycStatusEnum.accepted;
      case 'rejected':
        return KycStatusEnum.rejected;
      default:
        return null;
    }
  }

  static void _checkKycStats(WidgetRef ref, BuildContext context) {
    var kycStatus = UserStatsChecker.kycStatusFromString(
      ref.read(appAuthStateProvider.notifier).currentUser?.kycStatus,
    );
    if (kycStatus != null) {
      ref.read(userWalletProvider);
    }
    if (kycStatus == null) {
      Future.delayed(
        Duration(seconds: 3),
        () => showDialog(
          barrierDismissible: false,
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => CustomDialog(
            heading: "KYC Verification Required",
            subHeading:
                "To access all features and continue using your account without limits, please complete your identity verification.",
            proceedOp: () async {
              context.push("/kyc");
            },
          ),
        ),
      );
    }
  }

  static Future<bool> _checkCameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return false;
  }
}
