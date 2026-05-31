import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app_boot_strap.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/shared/shared.dart';
import 'package:mobile/core/shared/ui/widgets/button/default_button.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultButton(
                onPressed: () async {
                  var res = await ref
                      .read(appAuthStateProvider.notifier)
                      .logoutUser();
                  // ignore: use_build_context_synchronously
                  AppBootstrap.restart(context);
                  DefaultSnackBar.showSuccess(res.message);
                },
                text: "Log out",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
