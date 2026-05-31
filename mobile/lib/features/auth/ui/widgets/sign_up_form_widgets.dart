import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:mobile/features/auth/application/state/state.dart';
import 'package:mobile/features/auth/data/model/model.dart';
import 'package:mobile/features/auth/ui/widgets/auth_op_with_google.dart';
import '../../../../core/shared/shared.dart';
import '../../application/provider/provider.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({
    super.key,
    required GlobalKey<FormState> formState,
    required TextEditingController emailController,
    required TextEditingController passwordCOntroller,
    required TextEditingController firstnameController,
    required TextEditingController lastnameController,
  }) : _formState = formState,
       _emailController = emailController,
       _passwordCOntroller = passwordCOntroller,
       _firstNameCOntroller = firstnameController,
       _lastnameCOntroller = lastnameController;

  final GlobalKey<FormState> _formState;
  final TextEditingController _emailController;
  final TextEditingController _passwordCOntroller;
  final TextEditingController _firstNameCOntroller;
  final TextEditingController _lastnameCOntroller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _isLoading = ref.watch(
      signUpProvider.select((value) => value.isLoading),
    );

    ref.listen(signUpProvider, (prev, next) {
      next.whenOrNull(
        data: (data) => data.whenOrNull(
          unverified: (e) {
            DefaultSnackBar.showInfo(e.toString());
            context.pushNamed(
              AppRoutesNames.otp,
              extra: RequestOtpModel(
                email: _emailController.text.trim(),
                type: "create_account",
              ),
            );
          },
          error: (res) => DefaultSnackBar.showError(res.toString()),
          exist: (e) => DefaultSnackBar.showInfo(e.toString()),
          created: (res) {
            DefaultSnackBar.showSuccess(res.toString());
            DefaultSnackBar.showInfo("verify your email before proceeding...");
            context.pushNamed(
              AppRoutesNames.otp,
              extra: RequestOtpModel(
                email: _emailController.text.trim(),
                type: "create_account",
              ),
            );
          },
        ),
        error: (err, _) => DefaultSnackBar.showError(err.toString()),
        loading: () =>
            DefaultSnackBar.showInfo("Submitting your information..."),
      );
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: KSize.symmetricHorizontal),
      child: Form(
        key: _formState,
        child: Column(
          children: [
            SizedBox(height: KDevice.getHeight(context) * 0.02),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: _isLoading,
                    controller: _firstNameCOntroller,
                    validator: (value) =>
                        KValidators.validateName(value!.trim()),
                    decoration: InputDecoration(
                      hintText: "Gibran",
                      labelText: "First Name",
                      prefixIcon: Icon(FontAwesomeIcons.user, size: KSize.icon),
                    ),
                  ),
                ),
                SizedBox(width: KDevice.getHeight(context) * 0.01),
                Expanded(
                  child: TextFormField(
                    readOnly: _isLoading,
                    controller: _lastnameCOntroller,
                    validator: (value) =>
                        KValidators.validateName(value!.trim()),
                    decoration: InputDecoration(
                      hintText: "James",
                      labelText: "Last Name",
                      prefixIcon: Icon(FontAwesomeIcons.user, size: KSize.icon),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: KDevice.getHeight(context) * 0.03),

            TextFormField(
              readOnly: _isLoading,
              controller: _emailController,
              validator: (value) => KValidators.validateEmail(value!.trim()),
              decoration: InputDecoration(
                hintText: "Enter your email",
                labelText: "Email",
                prefixIcon: Icon(
                  FontAwesomeIcons.addressBook,
                  size: KSize.icon,
                ),
              ),
            ),
            SizedBox(height: KDevice.getHeight(context) * 0.03),
            TextFormField(
              readOnly: _isLoading,
              validator: (value) => KValidators.validatePassword(value!.trim()),
              obscureText: true,
              controller: _passwordCOntroller,
              decoration: InputDecoration(
                hintText: "Enter your password",
                labelText: "******",
                prefixIcon: Icon(FontAwesomeIcons.lock, size: KSize.icon),
              ),
            ),

            SizedBox(height: KDevice.getHeight(context) * 0.04),
            DefaultButton(
              isLoading: _isLoading,
              onPressed: () {
                if (_formState.currentState!.validate()) {
                  ref
                      .read(signUpProvider.notifier)
                      .onSubmit(
                        SignUpModel(
                          email: _emailController.text.trim(),
                          firstName: _firstNameCOntroller.text.trim(),
                          lastName: _lastnameCOntroller.text.trim(),
                          password: _passwordCOntroller.text.trim(),
                        ),
                      );
                }
              },
              width: double.infinity,
              text: "Sign Up",
            ),
            SizedBox(height: KDevice.getHeight(context) * 0.03),
            Row(
              children: [
                Expanded(child: Divider()),
                Text("or"),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: KDevice.getHeight(context) * 0.04),
            AuthOpWithGoogle(title: "Sign Up with Google"),
          ],
        ),
      ),
    );
  }
}
