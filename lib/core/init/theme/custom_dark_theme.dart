
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constant/color.dart';
import 'package:portfolio/core/init/theme/custom_color_scheme.dart';
import 'package:portfolio/core/init/theme/custom_theme.dart';


/// Custom light theme for project design
final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorScheme.darkColorScheme,
        fontFamily: GoogleFonts.roboto().fontFamily,
        scaffoldBackgroundColor: ConsColor.darkThemeBackground,
        textTheme: textTheme,
        drawerTheme: drawerThemeData,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 16.0, color: ConsColor.cream),
        dividerTheme: const DividerThemeData( color: ConsColor.turquoise),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent
        ),
        cardTheme: CardTheme(
          color: ConsColor.darkThemeCard,
          shadowColor: ConsColor.darkThemeCardShadow,
        )


      
      );

  @override
    final DrawerThemeData drawerThemeData = DrawerThemeData(backgroundColor: ThemeData.dark().scaffoldBackgroundColor);

  @override
  final TextTheme textTheme = TextTheme(
          headlineLarge: ThemeData.dark().textTheme.headlineLarge!.copyWith(color: ConsColor.darkThemeHeader),
          headlineSmall: ThemeData.light().textTheme.headlineSmall!.copyWith(color: ConsColor.darkThemeHeader),
          titleLarge: ThemeData.dark().textTheme.titleLarge!.copyWith(color: ConsColor.darkThemeText),
          titleMedium: ThemeData.dark().textTheme.titleMedium!.copyWith(color: ConsColor.darkThemeText),
          titleSmall: ThemeData.dark().textTheme.titleSmall!.copyWith(color: ConsColor.darkThemeText),
          bodyMedium: ThemeData.dark().textTheme.bodyMedium!.copyWith( color: ConsColor.darkThemeText)
        );
}