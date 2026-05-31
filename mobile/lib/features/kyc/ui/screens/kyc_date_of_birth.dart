import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/core/shared/shared.dart';
import '../../../../core/constant/constant.dart';
import '../../application/provider/kyc_submtion_provider.dart';
import '../widgets/widgets.dart';

class KycDateOfBirth extends ConsumerStatefulWidget {
  const KycDateOfBirth({super.key, this.dob});
  final String? dob;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KycDateOfBirthState();
}

class _KycDateOfBirthState extends ConsumerState<KycDateOfBirth> {
  final TextEditingController _dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dobController.text = widget.dob ?? "";
  }

  void showCalender() async {
    final now = DateTime.now();
    final sixteenYearsAgo = DateTime(now.year - 19, DateTime.december, 31);

    final result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        firstDate: DateTime(1900),
        lastDate: sixteenYearsAgo,
        selectedDayHighlightColor: Theme.of(context).colorScheme.primary,
        // Add these to prevent overflow issues
        yearTextStyle: KTextStyles.bodyMedium(
          context,
        ).copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        dayTextStyle: KTextStyles.bodyMedium(context).copyWith(fontSize: 13),
        weekdayLabelTextStyle: KTextStyles.bodySmall(
          context,
        ).copyWith(fontSize: 11, fontWeight: FontWeight.w600),
        centerAlignModePicker: true,
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(20),
    );

    // Handle the selected date
    if (result != null && result.isNotEmpty && result.first != null) {
      final dt = result.first!;
      _dobController.text =
          "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
    }
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
                        "Date of Birth",
                        style: TextStyle().copyWith(letterSpacing: 1.5),
                      ),
                      Text(
                        "Provide your date of birth for verification.",
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
                      fieldOperation: _isLoading ? null : showCalender,
                      formKey: _formKey,
                      keyboardType: TextInputType.none,
                      readonly: true,
                      controller: _dobController,
                      icon: FontAwesomeIcons.calendar,
                      prefixWidget: IconButton(
                        onPressed: _isLoading ? null : showCalender,
                        icon: const Icon(Icons.calendar_month),
                      ),
                      heading: "When were you born?",
                      subHeading: "Age must be above 16 years",
                      colorScheme: colorScheme,
                      hintText: "2006-03-15",
                      maxLength: 11,
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
                    .addDob(dob: _dobController.text.trim());

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
