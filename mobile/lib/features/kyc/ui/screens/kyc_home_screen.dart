import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/application/provider/access_camera_status_provider.dart';
import 'package:mobile/features/kyc/application/provider/kyc_submtion_provider.dart';
import 'package:mobile/features/kyc/application/state/kyc_submittion_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/application/provider/provider.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/shared/shared.dart';
import '../../../auth/data/model/model.dart';
import '../widgets/widgets.dart';

class KycHomeScreen extends ConsumerStatefulWidget {
  const KycHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KycHomeScreenState();
}

class _KycHomeScreenState extends ConsumerState<KycHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final current = ref.read(kycSubmtionProvider);

      if (!current.hasValue) {
        var _ = ref.refresh(kycSubmtionProvider);
      }
      var _ = ref.refresh(accessCameraProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final kycState = ref.watch(kycSubmtionProvider);
    var currentUser = ref
        .watch(appAuthStateProvider.notifier)
        .currentUser;
    bool isLoading = kycState.isLoading;
    final formData = kycState.whenOrNull(
      loading: () => null,
      data: (state) => state.whenOrNull(formNotCompleted: (model, _) => model),
    );

    ref.listen<AsyncValue<KycSubmittionState>>(kycSubmtionProvider, (prev, next) {
      if (prev == next) return;
      next.when(
        loading: () => null,
        data: (state) {
          state.whenOrNull(
            formNotCompleted: (_, message) {
              if (message != null) DefaultSnackBar.showInfo(message);
            },
            initial: (message) {
              DefaultSnackBar.showInfo(message.toString());
            },
          );
        },
        error: (err, stack) {
          DefaultSnackBar.showError(
            "An error occurred while creating kyc session",
          );
        },
      );
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: KSize.symmetricHorizontalX),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: Text(
                    "${formData?.steps == null ? 0 : formData?.steps.toString()}/5",
                    style: KTextStyles.bodyMedium(context),
                  ),
                ),
              ),
            ],
            title: Row(
              children: [
                DefaultAppBarBackButton(),
                const SizedBox(width: 10),
                Row(children: [Text("KYC Verification")]),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: _KycInfoWidget(),
            ),
          ),

          Skeletonizer.sliver(
            enabled: isLoading,
            child: SliverList(
              delegate: SliverChildListDelegate([
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -120,
                      top: -120,
                      child: CustomCircleWidgets(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: KSize.symmetricHorizontalX,
                      ),
                      child: Column(
                        children: [
                          KycCard(
                            status: formData?.bvn != null,
                            addOp: () {
                              context.pushNamed(
                                AppRoutesNames.bvn,
                                extra: formData?.bvn,
                              );
                            },
                            title: "Bank Verification",
                            subTitle:
                                "Securely link and verify your BVN details",
                            number: "1",
                          ),
                          KycCard(
                            status: formData?.address != null,
                            addOp: () => context.pushNamed(
                              AppRoutesNames.kycAddress,
                              extra: formData?.address,
                            ),
                            title: "Residential Address",
                            subTitle:
                                "Provide your current home address for verification",
                            number: "2",
                          ),
                          KycCard(
                            status: formData?.profileUrl != null,
                            addOp: () => context.pushNamed(
                              AppRoutesNames.faceReg,
                              extra: formData?.profileUrl,
                            ),
                            title: "Face Verification",
                            subTitle:
                                "Take a quick selfie to confirm your identity",
                            number: "3",
                          ),
                          KycCard(
                            status: formData?.dateOfBirth != null,
                            addOp: () => context.pushNamed(
                              AppRoutesNames.kycDob,
                              extra: formData?.dateOfBirth,
                            ),
                            title: "Date of Birth",
                            subTitle:
                                "Confirm your birth details for identity validation",
                            number: "4",
                          ),
                          KycCard(
                            status: formData?.phone != null,
                            addOp: () => context.pushNamed(
                              AppRoutesNames.kycPhoneNumber,
                              extra: formData?.phone,
                            ),
                            title: "Phone Number",
                            subTitle:
                                "Provide your phone number for identity validation",
                            number: "5",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: DefaultButton(
          onPressed: formData?.steps != 5
              ? null
              : () {
                  context.pushNamed(
                    AppRoutesNames.otp,
                    extra: RequestOtpModel(
                      email: currentUser!.email,
                      type: "kyc_submittion",
                    ),
                  );
                },
          width: double.infinity,
          text: "Submit",
        ),
      ),
    );
  }
}

class _KycInfoWidget extends StatelessWidget {
  const _KycInfoWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: KSize.symmetricHorizontalX),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        constraints: BoxConstraints(minHeight: 50),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withAlphaOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withAlphaOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline_rounded),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                "We just need a few details to verify your identity. This keeps your account safe and fully activated.",
                style: KTextStyles.bodySmall(
                  context,
                ).copyWith(fontSize: 12, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
