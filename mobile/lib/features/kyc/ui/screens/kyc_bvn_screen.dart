import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/helpers/validators.dart';
import 'package:mobile/features/kyc/application/provider/kyc_submtion_provider.dart';

import '../../../../core/shared/shared.dart';
import '../widgets/widgets.dart';

class KycBvnScreen extends ConsumerStatefulWidget {
  const KycBvnScreen({super.key, this.initialBvn});
  final String? initialBvn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KycBvnScreenState();
}

class _KycBvnScreenState extends ConsumerState<KycBvnScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bvn = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _bvn.text = widget.initialBvn ?? "";
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
                        "Bank Verification",
                        style: TextStyle().copyWith(letterSpacing: 1.5),
                      ),

                      Text(
                        "Verify your identity using your BVN",
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
                      controller: _bvn,
                      keyboardType: TextInputType.number,
                      formKey: _formKey,
                      heading: "BVN Details",
                      subHeading: "Please enter your 11-digit BVN to continue.",
                      colorScheme: colorScheme,
                      hintText: "29401395718",
                      maxLength: 11,
                      validator: KValidators.validateBvn,
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
                    .addBvn(bvn: _bvn.text.trim());

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
