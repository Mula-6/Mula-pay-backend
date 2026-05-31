// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:mobile/core/constant/colors.dart';
import 'package:mobile/core/constant/test_styles.dart';
import 'package:pinput/pinput.dart';

class KPinTheme {
  final BuildContext context;
  KPinTheme(this.context);

  PinTheme get defaultPinTheme => PinTheme(
    width: 56,
    height: 56,
    
    textStyle: KTextStyles.titleMedium(context).copyWith(),
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      borderRadius: BorderRadius.circular(12),
    ),
  );

  PinTheme get focusedPinTheme => defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      color: KColors.primary.withAlphaOpacity(0.1),
      border: Border.all(color: KColors.primary)
    ),
  );

}


// final submittedPinTheme = defaultPinTheme.copyWith(
//   decoration: defaultPinTheme.decoration.copyWith(
//     color: Color.fromRGBO(234, 239, 243, 1),
//   ),
// );

// // return Pinput(
// // defaultPinTheme: defaultPinTheme,
// // focusedPinTheme: focusedPinTheme,
// // submittedPinTheme: submittedPinTheme,
// // validator: (s) {
// // return s == '2222' ? null : 'Pin is incorrect';
// // },
// // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
// // showCursor: true,
// // onCompleted: (pin) => print(pin),
// // );
