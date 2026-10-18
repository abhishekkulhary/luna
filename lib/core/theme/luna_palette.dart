import 'package:flutter/material.dart';

/// Surface and accent tokens for Luna's "moonlit" look: a night-sky backdrop
/// with soft glows, frosted glass panels and a rose → lavender accent.
@immutable
class LunaPalette extends ThemeExtension<LunaPalette> {
  const LunaPalette({
    required this.sky,
    required this.skyDeep,
    required this.glass,
    required this.glassStrong,
    required this.glassBorder,
    required this.glowRose,
    required this.glowViolet,
    required this.star,
    required this.accentStart,
    required this.accentEnd,
    required this.onAccent,
  });

  /// Base backdrop colour (top of the sky gradient).
  final Color sky;

  /// Bottom of the sky gradient.
  final Color skyDeep;

  /// Fill for frosted panels and cards.
  final Color glass;

  /// Slightly stronger fill for raised elements (keys, chips, nav bar).
  final Color glassStrong;

  /// Hairline border around glass panels.
  final Color glassBorder;

  final Color glowRose;
  final Color glowViolet;
  final Color star;

  final Color accentStart;
  final Color accentEnd;

  /// Text/icon colour on top of the accent gradient.
  final Color onAccent;

  LinearGradient get accent => LinearGradient(
    colors: [accentStart, accentEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const dark = LunaPalette(
    sky: Color(0xFF110D24),
    skyDeep: Color(0xFF07060F),
    glass: Color(0x14FFFFFF),
    glassStrong: Color(0x1FFFFFFF),
    glassBorder: Color(0x26D9C8FF),
    glowRose: Color(0xFFE0457F),
    glowViolet: Color(0xFF6A4BDB),
    star: Color(0xFFFFFFFF),
    accentStart: Color(0xFFFF7AAE),
    accentEnd: Color(0xFFB08CFF),
    onAccent: Color(0xFF1A0B1F),
  );

  static const light = LunaPalette(
    sky: Color(0xFFFDF7FB),
    skyDeep: Color(0xFFF1ECFF),
    glass: Color(0xB3FFFFFF),
    glassStrong: Color(0xE6FFFFFF),
    glassBorder: Color(0x33A58BD8),
    glowRose: Color(0xFFFF9EC2),
    glowViolet: Color(0xFFB9A5FF),
    star: Color(0xFF8E6FD6),
    accentStart: Color(0xFFE5508D),
    accentEnd: Color(0xFF8A68F0),
    onAccent: Color(0xFFFFFFFF),
  );

  @override
  LunaPalette copyWith({
    Color? sky,
    Color? skyDeep,
    Color? glass,
    Color? glassStrong,
    Color? glassBorder,
    Color? glowRose,
    Color? glowViolet,
    Color? star,
    Color? accentStart,
    Color? accentEnd,
    Color? onAccent,
  }) {
    return LunaPalette(
      sky: sky ?? this.sky,
      skyDeep: skyDeep ?? this.skyDeep,
      glass: glass ?? this.glass,
      glassStrong: glassStrong ?? this.glassStrong,
      glassBorder: glassBorder ?? this.glassBorder,
      glowRose: glowRose ?? this.glowRose,
      glowViolet: glowViolet ?? this.glowViolet,
      star: star ?? this.star,
      accentStart: accentStart ?? this.accentStart,
      accentEnd: accentEnd ?? this.accentEnd,
      onAccent: onAccent ?? this.onAccent,
    );
  }

  @override
  LunaPalette lerp(ThemeExtension<LunaPalette>? other, double t) {
    if (other is! LunaPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return LunaPalette(
      sky: l(sky, other.sky),
      skyDeep: l(skyDeep, other.skyDeep),
      glass: l(glass, other.glass),
      glassStrong: l(glassStrong, other.glassStrong),
      glassBorder: l(glassBorder, other.glassBorder),
      glowRose: l(glowRose, other.glowRose),
      glowViolet: l(glowViolet, other.glowViolet),
      star: l(star, other.star),
      accentStart: l(accentStart, other.accentStart),
      accentEnd: l(accentEnd, other.accentEnd),
      onAccent: l(onAccent, other.onAccent),
    );
  }
}

/// Convenient access: `context.luna.accent`.
extension LunaPaletteX on BuildContext {
  LunaPalette get luna => Theme.of(this).extension<LunaPalette>()!;
}
