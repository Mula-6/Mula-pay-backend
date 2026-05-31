import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:mobile/core/application/provider/app_main_tabs_navigation_provider.dart';
import 'package:mobile/core/application/state/app_main_tabs_navigation_state.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/shared/shared.dart';

import '../../../helpers/helper.dart';

class MainShellWidgets extends ConsumerStatefulWidget {
  const MainShellWidgets({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainShellWidgetsState();
}

class _MainShellWidgetsState extends ConsumerState<MainShellWidgets> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserStatsChecker.init(ref, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var navReactive = ref.watch(appMainTabsNavigationProvider.notifier);
    var navOp = ref.read(appMainTabsNavigationProvider.notifier);
    ref.listen<AppMainTabsNavigationState>(appMainTabsNavigationProvider, (
      prev,
      next,
    ) {
      next.when(
        homeScreen: () => context.goNamed(AppRoutesNames.home),
        transferScreen: () => context.goNamed(AppRoutesNames.transfer),
        scanScreen: () => context.goNamed(AppRoutesNames.scan),
        settingsScreen: () => context.goNamed(AppRoutesNames.settings),
      );
    });

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SlideInAnimationWapper(
        delay: const Duration(milliseconds: 300),
        duration: const Duration(milliseconds: 400),
        child: Container(
          height: KDevice.getWidth(context) * 0.18,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withAlphaOpacity(0.4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ButtomBarItems(
                    title: "Home",
                    isActive: navReactive.isTabActive(
                      AppMainTabsNavigationState.homeScreen(),
                    ),
                    icons: HugeIconsStrokeRounded.home01,
                    navigate: () => navOp.navigateToHomeScreen(),
                  ),

                  _ButtomBarItems(
                    title: "Transfer",
                    icons: HugeIconsStrokeRounded.wallet01,
                    isActive: navReactive.isTabActive(
                      AppMainTabsNavigationState.transferScreen(),
                    ),
                    navigate: () => navOp.navigateToTransferScreen(),
                  ),
                  _ButtomBarItems(
                    title: "Scan",
                    isActive: navReactive.isTabActive(
                      AppMainTabsNavigationState.scanScreen(),
                    ),
                    icons: HugeIconsStrokeRounded.copy01,
                    navigate: () => navOp.navigateToScanScreen(),
                  ),
                  _ButtomBarItems(
                    isActive: navReactive.isTabActive(
                      AppMainTabsNavigationState.settingsScreen(),
                    ),
                    title: "Settings",
                    icons: HugeIconsStrokeRounded.settings05,
                    navigate: () => navOp.navigateToSettingsScreen(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtomBarItems extends StatelessWidget {
  const _ButtomBarItems({
    required this.title,
    this.icons = HugeIconsStrokeRounded.home01,
    this.navigate,
    this.isActive = false,
  });

  final VoidCallback? navigate;
  final List<List<dynamic>> icons;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: navigate,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HugeIcon(
                size: 22,
                icon: icons,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlphaOpacity(0.8),
              ),
              Text(
                title,
                style: KTextStyles.bodyMedium(context).copyWith(
                  fontSize: 12,
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlphaOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}