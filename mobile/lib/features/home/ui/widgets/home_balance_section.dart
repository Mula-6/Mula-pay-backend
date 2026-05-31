import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/core/application/state/wallet_state.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:mobile/core/helpers/number_formatter.dart';
import 'package:mobile/core/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/application/provider/provider.dart';
import '../../../../core/constant/constant.dart';
import '../../applications/provider/provider.dart';
import '../../applications/state/state.dart';

class HomeBalanceSection extends ConsumerWidget {
  const HomeBalanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = ref.watch(appAuthStateProvider.notifier).currentUser;
    final balanceVisible = ref.watch(
      balanceVisibilityProvider.select(
        (state) => state == HomeBalanceVisibilityState.show(),
      ),
    );

    var kycStatus = UserStatsChecker.kycStatusFromString(
      currentUser?.kycStatus,
    );
    var virtualAccoutInfo = ref
        .read(appAuthStateProvider.notifier)
        .currentUserVirtualAccount;
    var userWallet = ref
        .watch(userWalletProvider)
        .whenOrNull(data: (dt) => dt.whenOrNull(walletInfo: (info) => info));

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isLoading = ref.watch(userWalletProvider).isLoading;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: KSize.symmetricHorizontal,
          vertical: KSize.symmetricVerticalX,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface.withAlphaOpacity(0.08),
              colorScheme.surface,
              colorScheme.surface,
              colorScheme.secondary,
            ],
            stops: [0.0, 0.3, 1.0, 0.5],
          ),
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlphaOpacity(0.05),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: colorScheme.primary.withAlphaOpacity(0.05),
              blurRadius: 20,

              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 10,
              bottom: 10,
              child: CustomCircleWidgets(width: 125, height: 125),
            ),
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colorScheme.primary.withAlphaOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: [0.1, 1.0],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Align(
                    alignment: Alignment.center,
                    child: KycStatusTag(kycStatus: kycStatus),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withAlphaOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.outline.withAlphaOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Total Balance",
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurface.withAlphaOpacity(
                                  0.6,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Account number section
                      if (virtualAccoutInfo != null)
                        GestureDetector(
                          onTap: () {
                            NumberFormatter.copyToClipboard(
                              virtualAccoutInfo.accountNumber,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Account number copied'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: colorScheme.primary.withAlphaOpacity(
                                  0.2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.copy,
                                  size: 12,
                                  color: colorScheme.primary.withAlphaOpacity(
                                    0.7,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  virtualAccoutInfo.accountNumber,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurface
                                        .withAlphaOpacity(0.6),
                                    fontFamily: 'monospace',
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Balance amount
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(balanceVisibilityProvider.notifier)
                          .toggleBalanceVisibility();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            balanceVisible
                                ? "*******"
                                : NumberFormatter.formatNumerWithCurrency(
                                    userWallet == null
                                        ? 0.00
                                        : double.parse(
                                            userWallet.walletBalance!,
                                          ),
                                  ),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.primary,
                              letterSpacing: -0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref
                                .read(balanceVisibilityProvider.notifier)
                                .toggleBalanceVisibility();
                          },
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.primary.withAlphaOpacity(0.1),
                            ),
                            child: Icon(
                              balanceVisible
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Cash flow indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outline.withAlphaOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Net Cash Flow",
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurface.withAlphaOpacity(
                                  0.6,
                                ),
                              ),
                            ),
                            Text(
                              "This month",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurface.withAlphaOpacity(
                                  0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: balanceVisible
                                ? colorScheme.surface.withAlphaOpacity(0.6)
                                : KColors.success.withAlphaOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              if (!balanceVisible)
                                Icon(
                                  Icons.trending_up_rounded,
                                  size: 14,
                                  color: KColors.success,
                                ),
                              const SizedBox(width: 4),
                              Text(
                                balanceVisible ? "****" : "+2.3%",
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: balanceVisible
                                      ? colorScheme.onSurface.withAlphaOpacity(
                                          0.4,
                                        )
                                      : KColors.success,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatItem(
                        context,
                        label: "Today's Income",
                        value: "45,230",
                        color: KColors.success,
                        visible: !balanceVisible,
                      ),
                      const SizedBox(width: 12),
                      _buildStatItem(
                        context,
                        label: "Today's Expenses",
                        value: "42,850",
                        color: colorScheme.error,
                        visible: !balanceVisible,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
    required bool visible,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlphaOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlphaOpacity(0.5),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              visible ? "$currencySign $value" : "******",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
