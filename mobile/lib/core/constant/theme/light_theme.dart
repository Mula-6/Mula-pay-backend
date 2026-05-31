import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/constant/colors.dart';

class KLightTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Modern color scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: KColors.primary,
      brightness: Brightness.light,
      primary: KColors.primary,
      secondary: KColors.chartBlue,
      tertiary: KColors.investment,
      error: KColors.error,
      surface: KColors.white,
      surfaceTint: KColors.primaryUltraLight,
      onPrimary: KColors.white,
      onSecondary: KColors.white,
      onSurface: KColors.black,
      outline: KColors.borderLight,
      outlineVariant: KColors.lightGrey,
    ),

    scaffoldBackgroundColor: KColors.backgroundLight,

    // Modern AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: KColors.backgroundLight,
      foregroundColor: KColors.black,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 4,
      surfaceTintColor: Colors.transparent,
      shadowColor: KColors.shadowLight.withAlphaOpacity(0.1),
      toolbarHeight: 64,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.5,
      ),
      iconTheme: const IconThemeData(color: KColors.black, size: 24),
      actionsIconTheme: const IconThemeData(color: KColors.black, size: 24),
    ),

    // Modern Card
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: KColors.borderLight, width: 1),
      ),
      color: KColors.cardLight,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shadowColor: KColors.shadowLight,
    ),

    // Modern Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: KColors.primary,
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
        backgroundColor: KColors.primary,
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
        foregroundColor: KColors.primary,
        side: const BorderSide(color: KColors.primary, width: 1.5),
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
        foregroundColor: KColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Modern Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: KColors.backgroundLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.lightGrey),
        gapPadding: 0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: KColors.primary, width: 1.5),
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
        color: KColors.textTertiary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      hintStyle: GoogleFonts.spaceGrotesk(
        color: KColors.textDisabled.withAlphaOpacity(0.8),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.spaceGrotesk(
        color: KColors.error,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: GoogleFonts.spaceGrotesk(
        color: KColors.primary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Modern Typography
    textTheme: TextTheme(
      // Display
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.8,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.6,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.4,
      ),

      // Headline
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.3,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.2,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: KColors.black,
        letterSpacing: -0.1,
      ),

      // Title
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: KColors.textPrimary,
        letterSpacing: 0.1,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: KColors.textPrimary,
        letterSpacing: 0.1,
      ),
      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: KColors.textSecondary,
        letterSpacing: 0.2,
      ),

      // Body
      bodyLarge: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: KColors.textSecondary,
        height: 1.6,
        letterSpacing: 0.1,
      ),
      bodyMedium: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.textSecondary,
        height: 1.6,
        letterSpacing: 0.1,
      ),
      bodySmall: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: KColors.textTertiary,
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
        color: KColors.textSecondary,
        letterSpacing: 0.3,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: KColors.textTertiary,
        letterSpacing: 0.4,
      ),
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
    // Modern Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      
      backgroundColor: KColors.white,
      selectedItemColor: KColors.primary,
      unselectedItemColor: KColors.grey,
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

    // Modern Tab Bar
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: KColors.primary,
      unselectedLabelColor: KColors.grey,
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
        borderSide: BorderSide(width: 3, color: KColors.primary),
      ),
      dividerColor: Colors.transparent,
    ),

    // Modern Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: KColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 12,
      shadowColor: KColors.shadowDark,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: KColors.black,
        letterSpacing: -0.3,
      ),
      contentTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        color: KColors.darkGrey,
        height: 1.6,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),

    // Modern Chip
    chipTheme: ChipThemeData(
      backgroundColor: KColors.ultraLightGrey,
      selectedColor: KColors.primaryUltraLight,
      disabledColor: KColors.lightGrey,
      labelStyle: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      secondaryLabelStyle: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    ),

    // Modern Divider
    dividerTheme: const DividerThemeData(
      color: KColors.borderLight,
      thickness: 1,
      space: 0,
      indent: 16,
      endIndent: 16,
    ),

    // Modern Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: KColors.primary,
      foregroundColor: KColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      highlightElevation: 8,
      splashColor: KColors.primary.withAlphaOpacity(0.2),
      sizeConstraints: const BoxConstraints.tightFor(width: 56, height: 56),
    ),

    // Modern SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: KColors.darkGrey.withAlphaOpacity(0.95),
      contentTextStyle: GoogleFonts.spaceGrotesk(color: KColors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actionTextColor: KColors.primaryLight,
    ),

    // Modern Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: KColors.primary,
      linearTrackColor: KColors.lightGrey,
      circularTrackColor: KColors.lightGrey,
      linearMinHeight: 4,
      refreshBackgroundColor: KColors.backgroundLight,
    ),

    // Modern List Tile
    listTileTheme: ListTileThemeData(
      tileColor: KColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      minLeadingWidth: 40,
      minVerticalPadding: 12,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: KColors.black,
      ),
      subtitleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.grey,
      ),
      leadingAndTrailingTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KColors.grey,
      ),
    ),

    // Modern Navigation Rail
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: KColors.white,
      selectedIconTheme: const IconThemeData(color: KColors.primary, size: 24),
      unselectedIconTheme: const IconThemeData(color: KColors.grey, size: 24),
      selectedLabelTextStyle: GoogleFonts.spaceGrotesk(
        color: KColors.primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.spaceGrotesk(
        color: KColors.grey,
        fontWeight: FontWeight.w500,
      ),
      labelType: NavigationRailLabelType.selected,
      groupAlignment: -0.5,
    ),

    // Modern Popup Menu
    popupMenuTheme: PopupMenuThemeData(
      color: KColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      textStyle: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KColors.black,
      ),
      labelTextStyle: WidgetStateProperty.all(
        GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Modern Drawer
    drawerTheme: const DrawerThemeData(
      backgroundColor: KColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      elevation: 8,
      width: 280,
    ),

    // Modern Bottom Sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: KColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      elevation: 8,
      modalBackgroundColor: KColors.white,
      modalElevation: 16,
      constraints: const BoxConstraints(maxWidth: 640),
      dragHandleColor: KColors.grey.withAlphaOpacity(0.4),
      dragHandleSize: const Size(40, 4),
    ),
  );
}
