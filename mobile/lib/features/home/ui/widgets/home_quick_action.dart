import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:mobile/core/constant/colors.dart';
import 'package:mobile/core/constant/test_styles.dart';
import 'package:mobile/features/home/ui/widgets/widgets.dart';

import '../../../../core/application/provider/provider.dart';

class HomeQuickActions extends ConsumerWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.08),

            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.95),
          ],
          stops: [0.0, 0.8],
        ),
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlphaOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Actions",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlphaOpacity(0.8),
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Manage your finances instantly",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlphaOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(
                          context,
                        ).colorScheme.primary.withAlphaOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlphaOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Mula Pay",
                        style: KTextStyles.bodyMedium(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withAlphaOpacity(0.1),
                  Theme.of(context).colorScheme.primary.withAlphaOpacity(0.05),
                  Theme.of(context).colorScheme.primary.withAlphaOpacity(0.1),
                ],
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Send Money
                    HomeTabSections(
                      title: "Send",
                      logo: HugeIcon(icon: HugeIconsStrokeRounded.arrowUp04),
                      onTap: () {
                        ref
                            .read(appMainTabsNavigationProvider.notifier)
                            .navigateToTransferScreen();
                      },
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          KColors.primary.withAlphaOpacity(0.25),
                          KColors.primary.withAlphaOpacity(0.1),
                        ],
                      ),
                      iconColor: KColors.primary,
                      showBadge: false,
                    ),

                    // Top Up Wallet
                    HomeTabSections(
                      title: "Top Up",
                      logo: HugeIcon(icon: HugeIconsStrokeRounded.moneyAdd02),
                      onTap: () {
                        // Handle top up action
                        print("Top up tapped");
                      },
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          KColors.chartGreen.withAlphaOpacity(0.25),
                          KColors.chartGreen.withAlphaOpacity(0.1),
                        ],
                      ),
                      iconColor: KColors.chartGreen,
                      showBadge: true, // Show badge for promotions/new features
                    ),

                    // Vault/Savings
                    HomeTabSections(
                      title: "Vault",
                      logo: HugeIcon(icon: HugeIconsStrokeRounded.lock),
                      onTap: () {
                        // Handle vault/savings action
                        print("Vault tapped");
                      },
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.purpleAccent.withAlphaOpacity(0.25),
                          Colors.purple.withAlphaOpacity(0.1),
                        ],
                      ),
                      iconColor: Colors.purpleAccent,
                      showBadge: false,
                    ),

                    // Automate Payments
                    HomeTabSections(
                      title: "Automate",
                      logo: HugeIcon(icon: HugeIconsStrokeRounded.bot),
                      onTap: () {
                        // Handle automate payments action
                        print("Automate tapped");
                      },
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.orangeAccent.withAlphaOpacity(0.25),
                          Colors.orange.withAlphaOpacity(0.1),
                        ],
                      ),
                      iconColor: Colors.orangeAccent,
                      showBadge: false,
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
