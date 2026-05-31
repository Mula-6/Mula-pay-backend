import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/helpers/device.dart';
import 'package:mobile/core/shared/shared.dart';
import 'package:mobile/features/auth/ui/widgets/auth_greeting_section.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/helpers/validators.dart';
import '../../data/model/model.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constrains.maxHeight),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: -400,
                    bottom: -150,
                    child: Hero(tag: "circle", child: CustomCircleWidgets()),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: KDevice.getHeight(context) * 0.2,
                    ),
                    child: Column(
                      children: [
                        AuthGreetingSection(
                          heading: "Reset your password",
                          subHeading:
                              "Enter your registered email address to receive a secure one-time code.",
                        ),
                        SizedBox(height: KDevice.getHeight(context) * 0.04),
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: KSize.symmetricHorizontal,
                          ),
                          child: Form(
                            key: _formState,
                            child: Column(
                              children: [
                                TextFormField(
                                  
                                  validator: (value) =>
                                      KValidators.validateEmail(value),
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
                                SizedBox(
                                  height: KDevice.getHeight(context) * 0.04,
                                ),

                                DefaultButton(
                                 
                                  onPressed: () {
                                    if (_formState.currentState!.validate()) {
                                      context.pushNamed(
                                        AppRoutesNames.otp,
                                        extra: RequestOtpModel(
                                          email: _emailController.text.trim(),
                                          type: "forget_password",
                                        ),
                                      );
                                    }
                                  },
                                  width: double.infinity,
                                  text: "Request Otp",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
