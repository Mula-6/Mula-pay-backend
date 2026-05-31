import 'package:flutter/material.dart';

class DefaultOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool isLoading;
  final Widget? icon;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final bool expanded;
  final MainAxisSize mainAxisSize;

  const DefaultOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.isLoading = false,
    this.icon,
    this.foregroundColor,
    this.borderColor,
    this.height,
    this.width,
    this.padding,
    this.textStyle,
    this.borderRadius,
    this.expanded = false,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget content = isLoading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: foregroundColor ?? theme.colorScheme.primary,
            ),
          )
        : Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(text), // No inline styling here
            ],
          );

    if (expanded) {
      content = Expanded(child: content);
    }

    // Create button style with proper textStyle handling
    final buttonStyle = (style ?? OutlinedButton.styleFrom()).copyWith(
      side: WidgetStateProperty.resolveWith((states) {
        final isDisabled = states.contains(WidgetState.disabled);
        return BorderSide(
          color: isDisabled 
              ? theme.colorScheme.onSurface.withAlpha(96)
              : borderColor ?? theme.colorScheme.primary,
          width: 1.0,
        );
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return theme.colorScheme.onSurface.withAlpha(96);
        }
        return foregroundColor ?? theme.colorScheme.primary;
      }),
      padding: WidgetStateProperty.all(
        padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
      ),
      minimumSize: WidgetStateProperty.all(
        Size(width ?? 0, height ?? 48)
      ),
      maximumSize: width != null 
          ? WidgetStateProperty.all(Size(width!, double.infinity))
          : null,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      // CRITICAL FIX: Handle textStyle in ButtonStyle
      textStyle: WidgetStateProperty.resolveWith((states) {
        // Get base style from theme
        final baseStyle = theme.textTheme.labelLarge;
        
        if (baseStyle == null) {
          return textStyle?.copyWith(inherit: false);
        }
        
        // Create consistent style with inherit: false
        final defaultStyle = baseStyle.copyWith(
          inherit: false, // Force consistency
          fontWeight: FontWeight.w600,
          color: null, // Let foregroundColor handle color
        );
        
        // Merge with custom textStyle if provided
        return textStyle != null 
            ? defaultStyle.merge(textStyle).copyWith(inherit: false)
            : defaultStyle;
      }),
    );

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: content,
    );
  }
}