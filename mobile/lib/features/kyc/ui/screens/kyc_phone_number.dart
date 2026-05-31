import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/core/shared/shared.dart';
import 'package:mobile/features/kyc/ui/widgets/kyc_form_container.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/helpers/helper.dart';
import '../../application/provider/kyc_submtion_provider.dart';

class KycPhoneNumber extends ConsumerStatefulWidget {
  const KycPhoneNumber({super.key, this.initialPhone});
  final String? initialPhone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KycPhoneNumberState();
}

class _KycPhoneNumberState extends ConsumerState<KycPhoneNumber> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phone = TextEditingController();
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _phone.text = widget.initialPhone ?? "";
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                DefaultAppBarBackButton(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle().copyWith(letterSpacing: 1.5),
                      ),

                      Text(
                        "Verify your phone to secure your account",
                        style: KTextStyles.bodyMedium(context).copyWith(
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: KSize.symmetricVertical,
                  horizontal: KSize.symmetricHorizontalX,
                ),
                child: Column(
                  children: [
                    KycFormContainer(
                      readonly: _isLoading,
                      controller: _phone,
                      icon: FontAwesomeIcons.phone,
                      keyboardType: TextInputType.number,
                      formKey: _formKey,
                      heading: "Enter Your Phone Number",
                      subHeading: "We’ll send a verification code to this number.",
                      colorScheme: colorScheme,
                      hintText: "08022840612",
                      maxLength: 11,
                      validator: KValidators.validateNigerianPhone,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: DefaultButton(
          isLoading: _isLoading,
          onPressed: () async {
                if (_formKey.currentState!.validate()) {
              try {
                setState(() {
                  _isLoading = true;
                });
                var res = await ref
                    .read(kycSubmtionProvider.notifier)
                    .addPhone(phone: _phone.text.trim());

                res?.successful == true
                    ? DefaultSnackBar.showSuccess(res!.message)
                    : DefaultSnackBar.showError(res!.message);
              } finally {
                setState(() {
                  _isLoading = false;
                });
              }
            }
          },
          width: double.infinity,
          text: "Submit",
        ),
      ),
    );
  }

}