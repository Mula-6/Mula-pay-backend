import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/data/model/model.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/helpers/helper.dart';
import '../../../../core/shared/shared.dart';
import '../../application/provider/provider.dart';
import '../../application/state/state.dart';
import '../widgets/widgets.dart';

class EnterForgetPasswordScreen extends ConsumerStatefulWidget {
  const EnterForgetPasswordScreen({super.key, required this.token});
  final String token;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnterForgetPasswordScreenState();
}

class _EnterForgetPasswordScreenState
    extends ConsumerState<EnterForgetPasswordScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = ref.watch(
      forgetPasswordProvider.select((val) => val.isLoading),
    );
    ref.listen<AsyncValue<ForgetPasswordState>>(forgetPasswordProvider, (
      prev,
      next,
    ) {
      next.when(
        data: (data) => data.whenOrNull(
          error: (message) {
             context.pop();
            DefaultSnackBar.showInfo(message);
      
          },
          changed: (message) {
            DefaultSnackBar.showSuccess(message);
            context.goNamed(AppRoutesNames.login);
          },
        ),
        error: (e, st)
        {DefaultSnackBar.showError(e.toString());
        context.pop();
        },
        loading: () {
          DefaultSnackBar.showInfo("Submitting your input");
        },
      );
    });
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrain) => ConstrainedBox(
          constraints: BoxConstraints(minHeight: constrain.maxHeight),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: -400,
                top: -150,
                child: Hero(tag: "circle", child: CustomCircleWidgets()),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: KSize.symmetricHorizontal,
                  vertical: KSize.symmetricVertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: KDevice.getHeight(context) * 0.15),
                    AuthGreetingSection(
                      heading: "Create a New Password",
                      subHeading:
                          "Enter a strong new password to secure your account.",
                    ),
                    const SizedBox(height: 30),

                    Form(
                      key: _formState,
                      child: TextFormField(
                        readOnly: isLoading,
                        obscureText: _isVisible,
                        controller: _passwordController,
                        validator: (value) =>
                            KValidators.validatePassword(value),
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
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            size: KSize.icon,
                          ),
                        ),
                      ),
                    ),
                   
                    SizedBox(height: KDevice.getHeight(context) * 0.1),
                    DefaultButton(
                      isLoading: isLoading,
                      width: 250,
                      text: "Save",
                      onPressed: () async {
                        if (_formState.currentState!.validate()) {
                          await ref
                              .read(forgetPasswordProvider.notifier)
                              .submitNewPassword(
                                ForgetPasswordModel(
                                  password: _passwordController.text.trim(),
                                  token: widget.token,
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
