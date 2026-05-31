import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool isLoading;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final double? height;
  final double? width;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final bool expanded;
  final MainAxisSize mainAxisSize;

  const DefaultButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
    this.height,
    this.width,
    this.elevation = 2.0,
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
              color: foregroundColor ?? theme.colorScheme.onPrimary,
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
              Text(text),
            ],
          );

    if (expanded) {
      content = Expanded(child: content);
    }

    // Create base button style
    final buttonStyle = (style ?? ElevatedButton.styleFrom()).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor ?? theme.colorScheme.onSurface.withAlpha(30);
        }
        return backgroundColor ?? theme.colorScheme.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor ?? theme.colorScheme.onSurface.withAlpha(96);
        }
        return foregroundColor ?? theme.colorScheme.onPrimary;
      }),
      elevation: WidgetStateProperty.all(elevation),
      padding: WidgetStateProperty.all(padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
      minimumSize: WidgetStateProperty.all(Size(width ?? 0, height ?? 30)),
      maximumSize: width != null ? WidgetStateProperty.all(Size(width!, double.infinity)) : null,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      
      textStyle: WidgetStateProperty.resolveWith((states) {
  
        final baseStyle = theme.textTheme.labelLarge;
        
        if (baseStyle == null) return textStyle;
        
      
        return baseStyle.copyWith(
          inherit: false, 
          fontWeight: FontWeight.w600,
          color: null, 
        ).merge(textStyle); 
      }),
    );

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: content,
    );
  }
}