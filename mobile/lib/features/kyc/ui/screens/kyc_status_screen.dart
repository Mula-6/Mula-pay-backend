import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app_boot_strap.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/application/state/user_kyc_state.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:mobile/features/auth/ui/widgets/auth_greeting_section.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:mobile/features/kyc/application/provider/kyc_submtion_provider.dart';
import 'package:mobile/features/kyc/application/state/kyc_submittion_state.dart';
import 'package:mobile/features/kyc/data/repo/kyc_repo_impl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/shared/shared.dart';

class KycStatusScreen extends ConsumerStatefulWidget {
  const KycStatusScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KycStatusScreenState();
}

class _KycStatusScreenState extends ConsumerState<KycStatusScreen> {
  int activeStep = 0;
  bool rejected = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var _ = ref.refresh(userKycProvider);
      var _ = ref.refresh(userKycInfoProvider);
    });
  }

  KycStatusEnum? _getUserKycState() {
    var kycState = UserStatsChecker.kycStatusFromString(
      ref.read(appAuthStateProvider.notifier).currentUser?.kycStatus,
    );
    return kycState;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<KycSubmittionState>>(kycSubmtionProvider, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (dt) =>
            dt.whenOrNull(
              error: (e) => DefaultSnackBar.showError(e),
              formCompleted: (m) => DefaultSnackBar.showSuccess(m)),
      );
    });
    ref.listen<AsyncValue<UserKycState>>(userKycProvider, (prev, next) {
      if (prev?.value == next.value) return;
      next.whenOrNull(
        data: (dt) => dt.whenOrNull(
          inReview: (e) {
            setState(() {
              activeStep = 1;
            });
            DefaultSnackBar.showInfo(e);
          },
          accepted: (e) {
            setState(() {
              activeStep = 2;
            });
            DefaultSnackBar.showSuccess(e);
          },
          rejected: (e) {
            setState(() {
              rejected = false;
            });
            DefaultSnackBar.showError(e);
          },
        ),
      );
    });

    final isLoading = ref.watch(userKycProvider).isLoading;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          AppBootstrap.restart(context);
        }
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(right: -120, top: -120, child: CustomCircleWidgets()),

              // Add small bottom left decoration
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(KSize.symmetricHorizontal),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Small status indicator with slight shadow
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _KycStatusTag(
                            status:
                                _getUserKycState() ?? KycStatusEnum.inReview,
                          ),
                        ),
                        const SizedBox(height: 20),

                        AuthGreetingSection(
                          heading: "Verification Under Review",
                          subHeading:
                              "We're carefully reviewing your details to ensure everything is accurate and secure. You'll hear from us shortly.",
                        ),

                        const SizedBox(height: 30),

                        // EasyStepper Progress Indicator
                        EasyStepper(
                          lineStyle: LineStyle(
                            lineType: LineType.normal,
                            lineSpace: 0,
                            lineThickness: 2.5,
                            defaultLineColor: KColors.darkTextTertiary,
                            lineLength: 70,

                            finishedLineColor: KColors.primary,
                            activeLineColor: KColors.primary,
                          ),
                          activeStep: activeStep,

                          showLoadingAnimation: false,
                          stepRadius: 24,
                          showStepBorder: false,
                          steps: [
                            EasyStep(
                              icon: const Icon(
                                Icons.description_outlined,
                                size: 18,
                              ),
                              title: 'Submit',
                              activeIcon: const Icon(
                                Icons.description_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            EasyStep(
                              icon: const Icon(
                                Icons.visibility_outlined,
                                size: 18,
                              ),
                              title: 'Review',
                              activeIcon: const Icon(
                                Icons.visibility_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            EasyStep(
                              icon: const Icon(
                                Icons.check_circle_outline,
                                size: 18,
                              ),
                              title: 'Approval',
                              activeIcon: const Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Small estimated time card with icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Theme.of(
                                  context,
                                ).colorScheme.surface.withAlphaOpacity(0.8),

                                Theme.of(
                                  context,
                                ).colorScheme.surface.withAlphaOpacity(0.95),
                              ],
                              stops: [0.2, 0.8],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                size: 18,
                                color: Colors.orange.shade400,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Estimated time: 24-48 hours',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        DefaultButton(
                          onPressed: () async {
                            AppBootstrap.restart(context);
                            context.goNamed(AppRoutesNames.home);
                          },
                          text: "Return to home",
                        ),

                        const SizedBox(height: 16),

                        // Small text button with icon
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.help_outline,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          label: const Text(
                            'Need help? Contact support',
                            style: TextStyle(fontSize: 13),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KycStatusTag extends StatelessWidget {
  const _KycStatusTag({required this.status});

  final KycStatusEnum status;

  Color _getStatusColor() {
    switch (status) {
      case KycStatusEnum.accepted:
        return KColors.success; // You'll need to define this color
      case KycStatusEnum.rejected:
        return KColors.error; // You'll need to define this color
      case KycStatusEnum.inReview:
        return KColors.loan;
    }
  }

  String _getStatusText() {
    switch (status) {
      case KycStatusEnum.accepted:
        return 'Accepted';
      case KycStatusEnum.rejected:
        return 'Rejected';
      case KycStatusEnum.inReview:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withAlphaOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: statusColor.withAlphaOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _getStatusText(),
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
