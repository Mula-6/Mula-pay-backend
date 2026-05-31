import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/theme/pin_theme.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:mobile/core/shared/shared.dart';
import 'package:mobile/features/auth/application/state/state.dart';
import 'package:mobile/features/auth/data/model/model.dart';
import 'package:mobile/features/auth/data/model/submit_otp_email.dart';
import 'package:mobile/features/auth/ui/widgets/auth_greeting_section.dart';
import 'package:mobile/features/home/applications/provider/repo_provider.dart';
import 'package:mobile/features/kyc/application/provider/kyc_submtion_provider.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constant/constant.dart';
import '../../application/provider/provider.dart';

class EmailOtpScreen extends ConsumerStatefulWidget {
  const EmailOtpScreen({super.key, required this.model});
  final RequestOtpModel model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends ConsumerState<EmailOtpScreen> {
  String otpToken = "";
  final TextEditingController _pinInput = TextEditingController();
  final ValueNotifier<int> _secondsRemainig = ValueNotifier(0);
  final ValueNotifier<bool> _isRequesting = ValueNotifier(false);
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late ProviderSubscription<EmailOtpState> _subscription;

  @override
  void initState() {
    super.initState();
    debugPrint('EmailOtpScreen initState');
    _subscription = ref.listenManual<EmailOtpState>(emailOtpProvider, (
      prev,
      next,
    ) {
      if (next.maybeWhen(loading: () => true, orElse: () => false)) return;
      next.maybeWhen(
        verified: (msg) {
          if (!mounted) return;
          DefaultSnackBar.showSuccess(msg);

          if (widget.model.type == "create_account") {
            ref.read(homeRepoProvider).saveVisibilityBalanceState(true);
            context.goNamed(AppRoutesNames.login);
          } else if (widget.model.type == "kyc_submittion") {
            ref.read(kycSubmtionProvider.notifier).sumbmit();
            context.goNamed(AppRoutesNames.kycStatus);
          } else {
            context.pushReplacementNamed(
              AppRoutesNames.newPassword,
              extra: otpToken,
            );
          }
        },
        maxRetry: (msg) {
          if (!mounted) return;
          DefaultSnackBar.showInfo(msg);
        },
        unVerified: (msg) {
          if (!mounted) return;
          DefaultSnackBar.showError(msg);
        },
        requestOtp: (token) {
          otpToken = token.data!.token;
          if (!mounted) return;
          DefaultSnackBar.showSuccess(token.message);
        },
        error: (msg) {
          if (!mounted) return;
          DefaultSnackBar.showError(msg);
        },
        orElse: () => {},
      );
    }, fireImmediately: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      resend();
    });
  }

  void triggerResend() {
    int from = 60;
    _secondsRemainig.value = from;
    _isRequesting.value = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      from--;
      _secondsRemainig.value = from;

      if (from <= 0) {
        resend();
        _isRequesting.value = false;
        timer.cancel();
      }
    });
  }

  void resend() {
    if (widget.model.email.isNotEmpty) {
      ref.read(emailOtpProvider.notifier).requestOtp(model: widget.model);
    } else {
      debugPrint("empty");
    }
  }

  @override
  void dispose() {
    _pinInput.dispose();
    _secondsRemainig.dispose();
    _subscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(emailOtpProvider)
        .maybeWhen(loading: () => true, orElse: () => false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: KSize.symmetricHorizontal,
            vertical: KSize.symmetricVertical,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: KDevice.getHeight(context) * 0.15),
              AuthGreetingSection(
                heading: "Email Verification",
                subHeading:
                    "We’ve sent a 6-digit verification code to your email. Please enter it below to continue. The code is valid for only 7 minutes.",
              ),
              const SizedBox(height: 30),

              Form(
                key: _formState,
                child: Pinput(
                  validator: (value) => KValidators.validateSixDigitPin(value),
                  controller: _pinInput,
                  readOnly: isLoading,
                  defaultPinTheme: KPinTheme(context).defaultPinTheme,
                  length: 6,
                  onCompleted: (value) => ref
                      .read(emailOtpProvider.notifier)
                      .submitOtp(
                        otpModel: SubmitOtpEmail(
                          token: otpToken,
                          otp: value,
                          type: widget.model.type,
                        ),
                      ),
                  focusedPinTheme: KPinTheme(context).focusedPinTheme,
                  submittedPinTheme: KPinTheme(context).focusedPinTheme,
                ),
              ),
              SizedBox(height: KDevice.getHeight(context) * 0.05),
              ValueListenableBuilder(
                valueListenable: _secondsRemainig,
                builder: (context, sec, child) {
                  final canResend = sec <= 0;

                  return InkWell(
                    onTap: canResend ? triggerResend : null,
                    child: Text(
                      canResend ? "Resend OTP" : "Resend in $sec s",
                      style: KTextStyles.bodyMedium(context).copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlphaOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: KDevice.getHeight(context) * 0.1),
              ValueListenableBuilder(
                valueListenable: _isRequesting,
                builder: (context, requesting, child) {
                  return DefaultButton(
                    isLoading: isLoading,
                    width: 200,
                    text: "Verify",
                    onPressed: requesting
                        ? null
                        : isLoading
                        ? null
                        : () {
                            if (_formState.currentState!.validate()) {
                              ref
                                  .read(emailOtpProvider.notifier)
                                  .submitOtp(
                                    otpModel: SubmitOtpEmail(
                                      type: widget.model.type,
                                      token: otpToken,
                                      otp: _pinInput.text.trim(),
                                    ),
                                  );
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
