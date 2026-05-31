import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/application/provider/provider.dart';

import 'mula_pay.dart';

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key, required this.pref, required this.sPref});
  final SharedPreferences pref;
  final FlutterSecureStorage sPref;

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();

  static void restart(BuildContext context) {
    context.findAncestorStateOfType<_AppBootstrapState>()?.restart();
  }
}

class _AppBootstrapState extends State<AppBootstrap> {
  Key _key = UniqueKey();
  void restart() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: _key,
      overrides: [
        sharedPreferenceProvider.overrideWithValue(widget.pref),
        flutterSecureStorageProvider.overrideWithValue(widget.sPref),
      ],
      child: const MulaPay(),
    );
  }
}
