import 'package:flutter/material.dart';
import '../../../../core/constant/constant.dart';
import 'reciepient_tag_name.dart';

class TopSenderCard extends StatelessWidget {
  const TopSenderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Theme.of(context).colorScheme.onSurface.withAlphaOpacity(0.2),
        // ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.08),

            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.95),
          ],
          stops: [0.0, 0.8],
        ),
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlphaOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RecipeintTagName(abbrivation: "AV",),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Azudoni Victory",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transfers →", style: KTextStyles.bodySmall(context)),
                    Text(
                      "+6",
                      style: KTextStyles.labelSmall(
                        context,
                      ).copyWith(color: KColors.success),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
