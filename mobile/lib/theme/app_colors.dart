import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.canvas,
    required this.surface,
    required this.softSurface,
    required this.elevatedSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.lineSubtle,
    required this.accentMint,
    required this.accentLilac,
    required this.accentPeach,
    required this.accentSky,
    required this.accentButter,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.heroStart,
    required this.heroEnd,
  });

  final Color canvas;
  final Color surface;
  final Color softSurface;
  final Color elevatedSurface;
  final Color textPrimary;
  final Color textSecondary;
  final Color lineSubtle;
  final Color accentMint;
  final Color accentLilac;
  final Color accentPeach;
  final Color accentSky;
  final Color accentButter;
  final Color protein;
  final Color carbs;
  final Color fat;
  final Color fiber;
  final Color heroStart;
  final Color heroEnd;

  static const light = AppColors(
    canvas: Color(0xFFF5F6F8),
    surface: Color(0xFFFFFFFF),
    softSurface: Color(0xFFE7F5FB),
    elevatedSurface: Color(0xFFF8FDFF),
    textPrimary: Color(0xFF14314C),
    textSecondary: Color(0xFF6A88A3),
    lineSubtle: Color(0xFFD6E8F4),
    accentMint: Color(0xFF8DECF1),
    accentLilac: Color(0xFF9FC0FF),
    accentPeach: Color(0xFFFFD2E1),
    accentSky: Color(0xFFB7E4FF),
    accentButter: Color(0xFFDDF8FF),
    protein: Color(0xFFFF6B6B),
    carbs: Color(0xFFFF9F43),
    fat: Color(0xFFFFD93D),
    fiber: Color(0xFF6BCB77),
    heroStart: Color(0xFFD6F5FB),
    heroEnd: Color(0xFF79AEF8),
  );

  @override
  AppColors copyWith({
    Color? canvas,
    Color? surface,
    Color? softSurface,
    Color? elevatedSurface,
    Color? textPrimary,
    Color? textSecondary,
    Color? lineSubtle,
    Color? accentMint,
    Color? accentLilac,
    Color? accentPeach,
    Color? accentSky,
    Color? accentButter,
    Color? protein,
    Color? carbs,
    Color? fat,
    Color? fiber,
    Color? heroStart,
    Color? heroEnd,
  }) {
    return AppColors(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      softSurface: softSurface ?? this.softSurface,
      elevatedSurface: elevatedSurface ?? this.elevatedSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      lineSubtle: lineSubtle ?? this.lineSubtle,
      accentMint: accentMint ?? this.accentMint,
      accentLilac: accentLilac ?? this.accentLilac,
      accentPeach: accentPeach ?? this.accentPeach,
      accentSky: accentSky ?? this.accentSky,
      accentButter: accentButter ?? this.accentButter,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      heroStart: heroStart ?? this.heroStart,
      heroEnd: heroEnd ?? this.heroEnd,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      softSurface: Color.lerp(softSurface, other.softSurface, t)!,
      elevatedSurface: Color.lerp(elevatedSurface, other.elevatedSurface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      lineSubtle: Color.lerp(lineSubtle, other.lineSubtle, t)!,
      accentMint: Color.lerp(accentMint, other.accentMint, t)!,
      accentLilac: Color.lerp(accentLilac, other.accentLilac, t)!,
      accentPeach: Color.lerp(accentPeach, other.accentPeach, t)!,
      accentSky: Color.lerp(accentSky, other.accentSky, t)!,
      accentButter: Color.lerp(accentButter, other.accentButter, t)!,
      protein: Color.lerp(protein, other.protein, t)!,
      carbs: Color.lerp(carbs, other.carbs, t)!,
      fat: Color.lerp(fat, other.fat, t)!,
      fiber: Color.lerp(fiber, other.fiber, t)!,
      heroStart: Color.lerp(heroStart, other.heroStart, t)!,
      heroEnd: Color.lerp(heroEnd, other.heroEnd, t)!,
    );
  }
}

extension AppThemeColorsX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
