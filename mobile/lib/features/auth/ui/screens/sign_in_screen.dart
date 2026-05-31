import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/application/provider/app_auth_state_provider.dart';
import 'package:mobile/core/helpers/device.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/shared/shared.dart';
import '../../application/provider/provider.dart';
import '../../application/state/state.dart';
import '../../data/model/model.dart';
import '../widgets/auth_op_with_google.dart';
import '../widgets/widgets.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _isVisible = false;

  ProviderSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _subscription = ref.listenManual<SignInState>(signInProvider, (
        prev,
        next,
      ) {
        next.when(
          initial: () {},
          loading: () =>
              DefaultSnackBar.showInfo("Submitting your information..."),
          authenticated: (res) {
            DefaultSnackBar.showSuccess(res.message);
            ref
                .read(appAuthStateProvider.notifier)
                .setIsAuthenticated(res.data!);
          },
          unVerified: (message) {
            DefaultSnackBar.showInfo(message);
            context.push(
              "/auth/verify-email",
              extra: RequestOtpModel(
                email: _emailController.text.trim(),
                type: "create_account",
              ),
            );
          },
          inCorrectPassword: (message) => DefaultSnackBar.showInfo(message),
          notFound: (message) => DefaultSnackBar.showInfo(message),
          error: (message) => DefaultSnackBar.showError(message),
        );
      }, fireImmediately: false);
    });
  }

  @override
  void dispose() {
    _subscription?.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: -400,
                    top: -150,
                    child: Hero(tag: "circle", child: CustomCircleWidgets()),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: KDevice.getHeight(context) * 0.12,
                    ),
                    child: _signInBody(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signInBody() {
    var isLoading =
        ref.watch(
          signInProvider.select((val) => val.whenOrNull(loading: () => true)),
        ) ??
        false;
    return Column(
      children: [
        AuthGreetingSection(
          heading: "Welcome back!",
          subHeading:
              "Sign in to continue managing your money securely and with ease.",
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: KSize.symmetricHorizontal),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                SizedBox(height: KDevice.getHeight(context) * 0.02),
                TextFormField(
                  readOnly: isLoading,
                  validator: (value) => KValidators.validateEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    labelText: "Email",
                    prefixIcon: Icon(
                      FontAwesomeIcons.addressBook,
                      size: KSize.icon,
                    ),
                  ),
                ),
                SizedBox(height: KDevice.getHeight(context) * 0.02),
                TextFormField(
                  readOnly: isLoading,
                  obscureText: _isVisible,
                  controller: _passwordController,
                  validator: (value) => KValidators.validatePassword(value),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password",
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      child: Icon(
                        _isVisible
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: KSize.icon,
                      ),
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.lock, size: KSize.icon),
                  ),
                ),

                SizedBox(height: KDevice.getHeight(context) * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                

                    InkWell(
                      onTap: () => context.push("/auth/forget-password"),
                      child: Text("Forget password?"),
                    ),
                  ],
                ),

                SizedBox(height: KDevice.getHeight(context) * 0.04),
                DefaultButton(
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      ref
                          .read(signInProvider.notifier)
                          .signIn(
                            SignInModelRes(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                    }
                  },
                  width: double.infinity,
                  text: "Sign in",
                ),
                SizedBox(height: KDevice.getHeight(context) * 0.02),
                DefaultOutlinedButton(
                  onPressed: () => context.pushNamed(AppRoutesNames.register),
                  width: double.infinity,
                  text: "Create Account",
                ),
                SizedBox(height: KDevice.getHeight(context) * 0.04),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text("or"),
                    Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: KDevice.getHeight(context) * 0.04),
                AuthOpWithGoogle(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
