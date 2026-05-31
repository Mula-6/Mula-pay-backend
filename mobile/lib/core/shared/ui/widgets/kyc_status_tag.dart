import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/kyc/data/repo/kyc_repo_impl.dart';
import '../../../constant/constant.dart';

class KycStatusTag extends ConsumerWidget {
  const KycStatusTag({super.key, this.kycStatus});

  final KycStatusEnum? kycStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine color and label based on enum
    final Color statusColor;
    final String statusText;

    switch (kycStatus) {
      case null:
        statusColor = KColors.error;
        statusText = "Start your kyc verification";
        break;
      case KycStatusEnum.inReview:
        statusColor = KColors.loan;
        statusText = "Pending Verification";
        break;
      case KycStatusEnum.accepted:
        statusColor = KColors.success;
        statusText = "Verified";
        break;
      case KycStatusEnum.rejected:
        statusColor = KColors.error;
        statusText = "Rejected";
        break;
    }

    return GestureDetector(
      onTap: () {
        switch (kycStatus) {
          case null:
            context.pushNamed(AppRoutesNames.kyc);
            break;
          default:
            context.pushNamed(AppRoutesNames.kycStatus);
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: statusColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              statusText,
              style: KTextStyles.bodySmall(
                context,
              ).copyWith(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
