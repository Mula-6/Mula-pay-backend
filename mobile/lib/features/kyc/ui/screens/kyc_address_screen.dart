import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/features/kyc/application/provider/kyc_submtion_provider.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/shared/shared.dart';
import '../widgets/widgets.dart';

class KycAddressScreen extends ConsumerStatefulWidget {
  const KycAddressScreen({super.key,  this.initialAddress});
  final String? initialAddress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KycAddressScreenState();
}

class _KycAddressScreenState extends ConsumerState<KycAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _address = TextEditingController();
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _address.text = widget.initialAddress ?? "";
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
                        "Residential Address",
                        style: TextStyle().copyWith(letterSpacing: 1.5),
                      ),

                      Text(
                        "Help us confirm where you currently live",
                        style: KTextStyles.bodyMedium(
                          context,
                        ).copyWith(fontSize: 12),
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
                      icon: FontAwesomeIcons.locationDot,
                      formKey: _formKey,
                      controller: _address,
                      heading: "Enter Your Home Address",
                      subHeading:
                          "This information is required for identity compliance.",
                      colorScheme: colorScheme,
                      hintText: "12 Admiralty Way, Lekki Phase 1, Lagos",
                      maxLength: 120,
                      validator: KValidators.validateAddress,
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
                    .addAddress(address: _address.text.trim());

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
