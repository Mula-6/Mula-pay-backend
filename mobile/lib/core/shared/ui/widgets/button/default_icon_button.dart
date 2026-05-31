import 'package:flutter/material.dart';
// Icon button version
class DefaultIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final double size;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final String? tooltip;

  const DefaultIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.style,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
    this.size = 48,
    this.padding,
    this.borderRadius,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final buttonStyle = style ??
        IconButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor ?? theme.colorScheme.primary,
          disabledBackgroundColor: disabledColor,
          disabledForegroundColor: theme.colorScheme.onSurface.withAlpha(96),
          padding: padding ?? const EdgeInsets.all(12),
          minimumSize: Size(size, size),
          maximumSize: Size(size, size),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        );

    return IconButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      icon: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: foregroundColor ?? theme.colorScheme.primary,
              ),
            )
          : Icon(icon, size: 24),
      tooltip: tooltip,
    );
  }
}