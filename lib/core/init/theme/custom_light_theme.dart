
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constant/color.dart';
import 'package:portfolio/core/init/theme/custom_color_scheme.dart';
import 'package:portfolio/core/init/theme/custom_theme.dart';


/// Custom light theme for project design
final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorScheme: CustomColorScheme.lightColorScheme,
        scaffoldBackgroundColor: ConsColor.lightThemeBackground,
        textTheme: textTheme,
        drawerTheme: drawerThemeData,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 16.0, color: ConsColor.darkScaffold),
        dividerTheme: const DividerThemeData( color: ConsColor.lightDivider),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent
        ),
        cardTheme: CardTheme(
          color: ConsColor.lightThemeCard,
          shadowColor: ConsColor.lightThemeCardShadow,
        )

        
      );

  @override

    final DrawerThemeData drawerThemeData =  DrawerThemeData(backgroundColor: ThemeData.light().scaffoldBackgroundColor);
    @override
      final TextTheme textTheme = TextTheme(
          headlineLarge: ThemeData.light().textTheme.headlineLarge!.copyWith(color: ConsColor.lightThemeHeader),
          headlineSmall: ThemeData.light().textTheme.headlineSmall!.copyWith(color: ConsColor.lightThemeHeader),

          titleLarge: ThemeData.light().textTheme.titleLarge!.copyWith(color: ConsColor.lightThemeText),
          titleMedium: ThemeData.light().textTheme.titleMedium!.copyWith(color: ConsColor.lightThemeText),
          titleSmall: ThemeData.light().textTheme.titleSmall!.copyWith(color: ConsColor.lightThemeText),
          bodyMedium: ThemeData.light().textTheme.bodyMedium!.copyWith( color: ConsColor.lightThemeText)
        );
}