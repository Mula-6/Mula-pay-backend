import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/init_main.dart';

import 'app_boot_strap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "./assets/.env");

  final pref = await InitMain().initSharedPreference();
  final sPref = await InitMain().initSecureStorage();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => AppBootstrap(pref: pref, sPref: sPref),
    ),
  );
}
