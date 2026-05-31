import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class KDarkTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: KColors.primaryLight,
      brightness: Brightness.dark,
      primary: KColors.primaryLight,
      secondary: KColors.chartBlue,
      tertiary: KColors.investment,
      error: KColors.error,
      surface: KColors.cardDark,
      surfaceTint: KColors.primaryDark,
      onPrimary: KColors.white,
      onSecondary: KColors.white,
      onSurface: KColors.darkTextPrimary,
      outline: KColors.borderDark,
      outlineVariant: Color(0xFF475569),
    ),

    scaffoldBackgroundColor: KColors.backgroundDark,

    // Modern Dark AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: KColors.backgroundDark,
      foregroundColor: KColors.darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 4,
      surfaceTintColor: Colors.transparent,
      shadowColor: KColors.black.withAlphaOpacity(0.2),
      toolbarHeight: 64,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: KColors.darkTextPrimary, size: 24),
      actionsIconTheme: IconThemeData(color: KColors.darkTextPrimary, size: 24),
    ),

    // Modern Dark Card
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: KColors.borderDark, width: 1),
      ),
      color: KColors.cardDark,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withAlphaOpacity(0.2),
    ),

    // Modern Dark Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: KColors.primaryLight,
        foregroundColor: KColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        textStyle: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: KColors.primaryLight,
        foregroundColor: KColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: KColors.primaryLight,
        side: const BorderSide(color: KColors.primaryLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: KColors.primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Modern Dark Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: KColors.cardDark,

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.borderDark),
        gapPadding: 0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.primaryLight, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.error, width: 1.5),
      ),
      labelStyle: GoogleFonts.spaceGrotesk(
        color: KColors.darkTextTertiary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      hintStyle: GoogleFonts.spaceGrotesk(
        color: KColors.darkTextTertiary.withAlphaOpacity(0.7),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.spaceGrotesk(
        color: KColors.error,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: GoogleFonts.spaceGrotesk(
        color: KColors.primaryLight,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Modern Dark Typography
    textTheme: TextTheme(
      // Display
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.8,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.6,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.4,
      ),

      // Headline
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.3,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.2,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.1,
      ),

      // Title
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextPrimary,
        letterSpacing: 0.1,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextPrimary,
        letterSpacing: 0.1,
      ),
      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextSecondary,
        letterSpacing: 0.2,
      ),

      // Body
      bodyLarge: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: KColors.darkTextSecondary,
        height: 1.6,
        letterSpacing: 0.1,
      ),
      bodyMedium: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.darkTextSecondary,
        height: 1.6,
        letterSpacing: 0.1,
      ),
      bodySmall: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: KColors.darkTextTertiary,
        height: 1.6,
        letterSpacing: 0.2,
      ),

      // Label
      labelLarge: GoogleFonts.spaceGrotesk(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: KColors.white,
        letterSpacing: 0.3,
      ),
      labelMedium: GoogleFonts.spaceGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextSecondary,
        letterSpacing: 0.3,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextTertiary,
        letterSpacing: 0.4,
      ),
    ),

    // Modern Dark Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: KColors.cardDark,
      selectedItemColor: KColors.primaryLight,
      unselectedItemColor: KColors.darkTextTertiary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      unselectedLabelStyle: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    ),

    // Modern Dark Tab Bar
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: KColors.primaryLight,
      unselectedLabelColor: KColors.darkTextTertiary,
      labelStyle: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.2,
      ),
      unselectedLabelStyle: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.2,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: KColors.primaryLight),
      ),
      dividerColor: Colors.transparent,
    ),

    // Modern Dark Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: KColors.cardDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 12,
      shadowColor: Colors.black.withOpacity(0.4),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: KColors.darkTextPrimary,
        letterSpacing: -0.3,
      ),
      contentTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        color: KColors.darkTextSecondary,
        height: 1.6,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),

    // Modern Dark Chip
    chipTheme: ChipThemeData(
      backgroundColor: KColors.cardDark.withOpacity(0.6),
      selectedColor: KColors.primaryDark.withOpacity(0.3),
      disabledColor: KColors.borderDark,
      labelStyle: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: KColors.darkTextSecondary,
        letterSpacing: 0.2,
      ),
      secondaryLabelStyle: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: KColors.darkTextSecondary,
        letterSpacing: 0.2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: KColors.borderDark),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    ),

    // Modern Dark Divider
    dividerTheme: const DividerThemeData(
      color: KColors.borderDark,
      thickness: 1,
      space: 0,
      indent: 16,
      endIndent: 16,
    ),

    // Modern Dark Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: KColors.primaryLight,
      foregroundColor: KColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      highlightElevation: 8,
      splashColor: KColors.primaryLight.withAlphaOpacity(0.2),
      sizeConstraints: const BoxConstraints.tightFor(width: 56, height: 56),
    ),

    // Modern Dark SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: KColors.cardDark.withAlphaOpacity(0.95),
      contentTextStyle: GoogleFonts.spaceGrotesk(color: KColors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actionTextColor: KColors.primaryLight,
    ),

    // Modern Dark Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: KColors.primaryLight,
      linearTrackColor: KColors.borderDark,
      circularTrackColor: KColors.borderDark,
      linearMinHeight: 4,
      refreshBackgroundColor: KColors.backgroundDark,
    ),

    // Modern Dark List Tile
    listTileTheme: ListTileThemeData(
      tileColor: KColors.cardDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      minLeadingWidth: 40,
      minVerticalPadding: 12,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: KColors.darkTextPrimary,
      ),
      subtitleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.darkTextSecondary,
      ),
      leadingAndTrailingTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KColors.darkTextTertiary,
      ),
    ),

    // Modern Dark Navigation Rail
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: KColors.cardDark,
      selectedIconTheme: const IconThemeData(
        color: KColors.primaryLight,
        size: 24,
      ),
      unselectedIconTheme: const IconThemeData(
        color: KColors.darkTextTertiary,
        size: 24,
      ),
      selectedLabelTextStyle: GoogleFonts.spaceGrotesk(
        color: KColors.primaryLight,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.spaceGrotesk(
        color: KColors.darkTextTertiary,
        fontWeight: FontWeight.w500,
      ),
      labelType: NavigationRailLabelType.selected,
      groupAlignment: -0.5,
    ),

    // Modern Dark Popup Menu
    popupMenuTheme: PopupMenuThemeData(
      color: KColors.cardDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      textStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KColors.darkTextPrimary,
      ),
      labelTextStyle: WidgetStateProperty.all(
        GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Modern Dark Drawer
    drawerTheme: const DrawerThemeData(
      backgroundColor: KColors.backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      elevation: 8,
      width: 280,
    ),

    // Modern Dark Bottom Sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: KColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      elevation: 8,
      modalBackgroundColor: KColors.cardDark,
      modalElevation: 16,
      constraints: const BoxConstraints(maxWidth: 640),
      dragHandleColor: KColors.darkTextTertiary.withAlphaOpacity(0.4),
      dragHandleSize: const Size(40, 4),
    ),

    // Additional dark theme properties
    iconTheme: const IconThemeData(color: KColors.darkTextPrimary, size: 24),

    primaryIconTheme: const IconThemeData(
      color: KColors.primaryLight,
      size: 24,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return KColors.primaryLight;
        }
        return null;
      }),
      
      checkColor: WidgetStateProperty.all(KColors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: const BorderSide(color: KColors.borderDark),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return KColors.primaryLight;
        }
        return KColors.borderDark;
      }),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return KColors.primaryLight;
        }
        return KColors.darkTextTertiary;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return KColors.primaryLight.withOpacity(0.5);
        }
        return KColors.borderDark;
      }),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: KColors.cardDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: KColors.borderDark),
      ),
      textStyle: GoogleFonts.spaceGrotesk(
        color: KColors.darkTextPrimary,
        fontSize: 12,
      ),
    ),

    bannerTheme: MaterialBannerThemeData(
      backgroundColor: KColors.cardDark,
      contentTextStyle: GoogleFonts.spaceGrotesk(
        color: KColors.darkTextPrimary,
        fontSize: 14,
      ),
    ),
  );
}
