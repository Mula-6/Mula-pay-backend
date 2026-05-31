import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../constant/constant.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transactionType,
    required this.description,
    required this.amount,
    required this.time,
    required this.category,
    this.isSuccess = true,
    this.onTap,
  });

  final TransactionTypeEnum transactionType; // 'sent', 'received', 'topup', 'payment'
  final String description;
  final double amount;
  final String time;
  final String category;
  final bool isSuccess;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Define colors based on transaction type
    final Map<String, Color> typeColors = {
      'sent': Colors.redAccent,
      'received': Colors.green,
      'topup': Colors.blueAccent,
      'payment': Colors.orangeAccent,
      'refund': Colors.purpleAccent,
    };

    final Map<String, List<List<dynamic>>> typeIcons = {
      'sent': HugeIconsStrokeRounded.arrowUp04,
      'received': HugeIconsStrokeRounded.arrowDown04,
      'topup': HugeIconsStrokeRounded.moneyAdd02,
      'payment': HugeIconsStrokeRounded.creditCardAdd,
      'refund': HugeIconsStrokeRounded.creditCardNotAccept,
    };

    final Color primaryColor =
        typeColors[transactionType.name] ?? colorScheme.primary;
    final List<List<dynamic>> icon =
        typeIcons[transactionType.name] ?? HugeIconsStrokeRounded.helpCircle;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).colorScheme.surface.withAlphaOpacity(0.8),

              Theme.of(context).colorScheme.surface.withAlphaOpacity(0.95),
            ],
            stops: [0.2, 0.8],
          ),
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.primary.withAlphaOpacity(0.09),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(-3, -3),
            ),
            BoxShadow(
              color: colorScheme.surface.withAlphaOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon with gradient background
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlphaOpacity(0.15),
                    primaryColor.withAlphaOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withAlphaOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: HugeIcon(icon: icon, color: primaryColor, size: 22),
              ),
            ),

            const SizedBox(width: 16),

            // Transaction details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          description,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "${amount >= 0 ? '+' : ''}$currencySign ${amount.abs().toStringAsFixed(0)}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: amount >= 0 ? KColors.success : KColors.error,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      // Transaction type badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlphaOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          transactionType.name.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Category
                      Text(
                        "•",
                        style: TextStyle(
                          color: colorScheme.onSurface.withAlphaOpacity(0.3),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        category,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withAlphaOpacity(0.5),
                        ),
                      ),

                      const Spacer(),

                      // Time
                      Text(
                        time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withAlphaOpacity(0.4),
                          fontSize: 12,
                        ),
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
}
