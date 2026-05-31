import 'package:flutter/material.dart';
import 'package:mobile/core/constant/test_styles.dart';
import 'package:mobile/init_main.dart';

import '../../../constant/colors.dart';

enum SnackBarMessageType { info, success, error }

class DefaultSnackBar {
  static final GlobalKey<ScaffoldMessengerState>? _messanger = InitMain.scaffoldMessengerKey;

  static IconData _getIconForType(SnackBarMessageType type) {
    switch (type) {
      case SnackBarMessageType.success:
        return Icons.check_circle;
      case SnackBarMessageType.error:
        return Icons.error;
      case SnackBarMessageType.info:
      return Icons.info;
    }
  }

  // Get color for each message type
  static Color _getColorForType(SnackBarMessageType type) {
    switch (type) {
      case SnackBarMessageType.success:
        return KColors.success;
      case SnackBarMessageType.error:
        return KColors.error;
      case SnackBarMessageType.info:
      return KColors.chartPurple;
    }
  }

  static void show({
    SnackBarMessageType type = SnackBarMessageType.info,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    bool showIcon = true,
    bool showCloseIcon = true,
    DismissDirection dismissDirection = DismissDirection.horizontal,
  }) {
    if (_messanger?.currentState == null) {
      debugPrint('ScaffoldMessenger key is not available');
      return;
    }

    final theme = Theme.of(_messanger!.currentContext!);
    
    _messanger!.currentState!.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showIcon) ...[
              Icon(
                _getIconForType(type),
                color: _getColorForType(type),
                size: 24,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: KTextStyles.bodyMedium(_messanger!.currentContext!).copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showCloseIcon)
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () {
                  _messanger!.currentState!.hideCurrentSnackBar();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 16,
              ),
          ],
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: _getColorForType(type).withAlphaOpacity(0.2),
            width: 1,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: action,
        dismissDirection: dismissDirection,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // Convenience methods for specific message types
  static void showSuccess(String message, {Duration? duration}) {
    show(
      type: SnackBarMessageType.success,
      message: message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void showError(String message, {Duration? duration}) {
    show(
      type: SnackBarMessageType.error,
      message: message,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  static void showInfo(String message, {Duration? duration}) {
    show(
      type: SnackBarMessageType.info,
      message: message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void showWithAction({
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    SnackBarMessageType type = SnackBarMessageType.info,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      type: type,
      message: message,
      duration: duration,
      action: SnackBarAction(
        label: actionLabel,
        onPressed: onActionPressed,
        textColor: _getColorForType(type),
      ),
    );
  }

  // Clear all snackbars
  static void clear() {
    _messanger?.currentState?.clearSnackBars();
  }

  // Remove current snackbar
  static void hideCurrent() {
    _messanger?.currentState?.hideCurrentSnackBar();
  }
}

