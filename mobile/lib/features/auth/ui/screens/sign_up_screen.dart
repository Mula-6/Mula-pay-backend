import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/device.dart';
import '../../../../core/shared/shared.dart';
import '../widgets/auth_greeting_section.dart';
import '../widgets/sign_up_form_widgets.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordCOntroller = TextEditingController();
  final TextEditingController _firstNameCOntroller = TextEditingController();
  final TextEditingController _lastnameCOntroller = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordCOntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: -400,
                    bottom: -150,
                    child: Hero(tag: "circle", child: CustomCircleWidgets()),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: KDevice.getHeight(context) * 0.12,
                    ),
                    child: _signUpFormBody(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signUpFormBody() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthGreetingSection(
              heading: "Create your account",
              subHeading: "Let’s get you set up in just a few steps.",
            ),
            SignUpForm(
              firstnameController: _firstNameCOntroller,
              lastnameController: _lastnameCOntroller,
              formState: _formState,
              emailController: _emailController,
              passwordCOntroller: _passwordCOntroller,
            ),
          ],
        ),
      ],
    );
  }
}
