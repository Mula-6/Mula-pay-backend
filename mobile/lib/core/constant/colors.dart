import 'package:flutter/material.dart';

class KColors {
  // Primary Color Scheme (#6366F1)
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF8183F4);
  static const Color primaryDark = Color(0xFF4F52C1);
  static const Color primaryUltraLight = Color(0xFFE0E1FC);

  // Neutral Colors
  static const Color black = Color(0xFF1A1A1A);
  static const Color darkGrey = Color(0xFF3A3A3A);
  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFD1D5DB);
  static const Color ultraLightGrey = Color(0xFFF3F4F6);
  static const Color white = Color(0xFFFFFFFF);

  // Financial Status Colors
  static const Color success = Color(0xFF10B981); // Green for profit/positive
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFEF4444); // Red for loss/negative
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B); // Yellow for caution
  static const Color warningLight = Color(0xFFFEF3C7);

  // Chart & Data Visualization Colors
  static const Color chartBlue = Color(0xFF3B82F6);
  static const Color chartGreen = Color(0xFF10B981);
  static const Color chartPurple = Color(0xFF8B5CF6);
  static const Color chartOrange = Color(0xFFF97316);
  static const Color chartPink = Color(0xFFEC4899);
  static const Color chartTeal = Color(0xFF14B8A6);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  // Border Colors
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF334155);

  // Shadow Colors
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowDark = Color(0x1A000000);

  // Gradient Colors for Fintech UI
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get successGradient => const LinearGradient(
    colors: [success, Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get premiumGradient => const LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Text Colors with Opacity Variants
  static const Color textPrimary = black;
  static const Color textSecondary = darkGrey;
  static const Color textTertiary = grey;
  static const Color textDisabled = lightGrey;
  static const Color textInverse = white;
  static const Color textSuccess = success;
  static const Color textError = error;

  // Interactive States
  static const Color hoverOverlay = Color(0x0A000000);
  static const Color focusRing = Color(0x336366F1);
  static const Color pressedOverlay = Color(0x14000000);

  // Special Fintech Colors
  static const Color investment = Color(0xFF8B5CF6); // Purple for investments
  static const Color savings = Color(0xFF06B6D4); // Cyan for savings
  static const Color loan = Color(0xFFF97316); // Orange for loans
  static const Color insurance = Color(0xFFEC4899); // Pink for insurance

  // Overlay Colors
  static const Color overlay60 = Color(0x99000000);
  static const Color overlay30 = Color(0x4D000000);
  static const Color overlay10 = Color(0x1A000000);

  // Accessibility: Ensure sufficient contrast
  static Color get textOnPrimary =>
      primary.computeLuminance() > 0.5 ? black : white;

  // Dark Theme Variants
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);

  
}
extension ColorAlpha on Color {
  Color withAlphaOpacity(double opacity) {
    return withAlpha((opacity * 255).round().clamp(0, 255));
  }
}



extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }
}
