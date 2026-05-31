import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/constant/constant.dart';

class NumberFormatter {
  static final formatter = NumberFormat('#,##0.00');
  static String formatNumerWithCurrency(double ammount) =>
      "$currencySign ${formatter.format(ammount)}";

  static void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
