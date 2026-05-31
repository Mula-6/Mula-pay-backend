
import 'package:flutter/material.dart';
import 'package:mobile/core/constant/colors.dart';
import '../../../../core/constant/constant.dart';


class HomeTabSections extends StatelessWidget {
  const HomeTabSections({
    super.key,
    required this.title,
    required this.logo,
    this.onTap,
    this.isSelected = false,
    this.gradient,
    this.iconColor,
    this.showBadge = false,
  });

  final String title;
  final Widget logo;
  final VoidCallback? onTap;
  final bool isSelected;
  final Gradient? gradient;
  final Color? iconColor;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient:
                      gradient ??
                      (isSelected
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colorScheme.primary.withAlphaOpacity(0.2),
                                colorScheme.primary.withAlphaOpacity(0.1),
                              ],
                            )
                          : LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colorScheme.surface.withAlphaOpacity(0.8),
                                colorScheme.surface.withAlphaOpacity(0.4),
                              ],
                            )),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.onSurface.withAlphaOpacity(0.1),
                    width: 0.3,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: colorScheme.primary.withAlphaOpacity(0.15),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    BoxShadow(
                      color: iconColor!.withAlphaOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                    // BoxShadow(
                    //   color: Colors.white.withAlphaOpacity(0.1),
                    //   blurRadius: 8,
                    //   offset: const Offset(-2, -2),
                    // ),
                  ],
                ),
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      color:
                          iconColor ??
                          (isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface.withAlphaOpacity(0.7)),
                      size: 24,
                    ),
                    child: logo,
                  ),
                ),
              ),

              // Badge indicator
              if (showBadge)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.surface, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlphaOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 2),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withAlphaOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withAlphaOpacity(0.6),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
