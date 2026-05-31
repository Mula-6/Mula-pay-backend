import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/shared/go_route_config.dart';
import 'package:mobile/init_main.dart';

class MulaPay extends ConsumerWidget {
  const MulaPay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var routes = ref.watch(mainRouterProvider);
    ref.watch(accessCameraProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: InitMain.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: routes,
    );
  }
}
