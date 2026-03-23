import 'package:flutter/material.dart';
import 'package:zen_pulse/providers/settings_provider.dart';

@immutable
class AuraPalette extends ThemeExtension<AuraPalette> {
  final Color primary;
  final Color primaryDark;
  final Color accent;
  final Color surface;
  final Color scaffoldBackground;
  final Color card;
  final Color textMuted;
  final Color premiumBadge;
  final Color glass;
  final Color glassBorder;
  final List<Color> backgroundGradient;
  final List<Color> heroGradient;
  final List<Color> buttonGradient;
  final List<Color> meditationTints;

  const AuraPalette({
    required this.primary,
    required this.primaryDark,
    required this.accent,
    required this.surface,
    required this.scaffoldBackground,
    required this.card,
    required this.textMuted,
    required this.premiumBadge,
    required this.glass,
    required this.glassBorder,
    required this.backgroundGradient,
    required this.heroGradient,
    required this.buttonGradient,
    required this.meditationTints,
  });

  @override
  AuraPalette copyWith({
    Color? primary,
    Color? primaryDark,
    Color? accent,
    Color? surface,
    Color? scaffoldBackground,
    Color? card,
    Color? textMuted,
    Color? premiumBadge,
    Color? glass,
    Color? glassBorder,
    List<Color>? backgroundGradient,
    List<Color>? heroGradient,
    List<Color>? buttonGradient,
    List<Color>? meditationTints,
  }) {
    return AuraPalette(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      accent: accent ?? this.accent,
      surface: surface ?? this.surface,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      card: card ?? this.card,
      textMuted: textMuted ?? this.textMuted,
      premiumBadge: premiumBadge ?? this.premiumBadge,
      glass: glass ?? this.glass,
      glassBorder: glassBorder ?? this.glassBorder,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      meditationTints: meditationTints ?? this.meditationTints,
    );
  }

  @override
  AuraPalette lerp(ThemeExtension<AuraPalette>? other, double t) {
    if (other is! AuraPalette) {
      return this;
    }

    Color lerpColor(Color a, Color b) => Color.lerp(a, b, t) ?? a;
    List<Color> lerpList(List<Color> a, List<Color> b) {
      final length = a.length < b.length ? a.length : b.length;
      return List<Color>.generate(length, (i) => lerpColor(a[i], b[i]));
    }

    return AuraPalette(
      primary: lerpColor(primary, other.primary),
      primaryDark: lerpColor(primaryDark, other.primaryDark),
      accent: lerpColor(accent, other.accent),
      surface: lerpColor(surface, other.surface),
      scaffoldBackground: lerpColor(
        scaffoldBackground,
        other.scaffoldBackground,
      ),
      card: lerpColor(card, other.card),
      textMuted: lerpColor(textMuted, other.textMuted),
      premiumBadge: lerpColor(premiumBadge, other.premiumBadge),
      glass: lerpColor(glass, other.glass),
      glassBorder: lerpColor(glassBorder, other.glassBorder),
      backgroundGradient: lerpList(
        backgroundGradient,
        other.backgroundGradient,
      ),
      heroGradient: lerpList(heroGradient, other.heroGradient),
      buttonGradient: lerpList(buttonGradient, other.buttonGradient),
      meditationTints: lerpList(meditationTints, other.meditationTints),
    );
  }
}

extension AuraThemePalette on AuraTheme {
  AuraPalette get palette {
    switch (this) {
      case AuraTheme.deepMind:
        return const AuraPalette(
          primary: Color(0xFF5C35B5),
          primaryDark: Color(0xFF3D1F8F),
          accent: Color(0xFF8B6BE8),
          surface: Color(0xFF271A4A),
          scaffoldBackground: Color(0xFF1C1538),
          card: Color(0xFF30215C),
          textMuted: Color(0xB3FFFFFF),
          premiumBadge: Color(0xFFFFD700),
          glass: Color(0x1FFFFFFF),
          glassBorder: Color(0x33FFFFFF),
          backgroundGradient: [
            Color(0xFF3D1E7A),
            Color(0xFF2A1754),
            Color(0xFF1A0F3A),
          ],
          heroGradient: [Color(0xFF8B6BE8), Color(0xFF5C35B5)],
          buttonGradient: [Color(0xFF8B6BE8), Color(0xFF5C35B5)],
          meditationTints: [
            Color(0xFF2C1E5F),
            Color(0xFF3E2675),
            Color(0xFF4D2C8F),
            Color(0xFF5F38A7),
            Color(0xFF422770),
            Color(0xFF6C44BA),
            Color(0xFF2A1B4F),
            Color(0xFF52339A),
            Color(0xFF6B3DB7),
            Color(0xFF3A246C),
          ],
        );
      case AuraTheme.naturePath:
        return const AuraPalette(
          primary: Color(0xFF2E7D32),
          primaryDark: Color(0xFF1F5B22),
          accent: Color(0xFF67C76C),
          surface: Color(0xFF1C3A26),
          scaffoldBackground: Color(0xFF14281C),
          card: Color(0xFF264E30),
          textMuted: Color(0xB3E8F5E9),
          premiumBadge: Color(0xFFFFD700),
          glass: Color(0x1FFFFFFF),
          glassBorder: Color(0x33C8E6C9),
          backgroundGradient: [
            Color(0xFF226330),
            Color(0xFF1A4A24),
            Color(0xFF132B18),
          ],
          heroGradient: [Color(0xFF67C76C), Color(0xFF2E7D32)],
          buttonGradient: [Color(0xFF67C76C), Color(0xFF2E7D32)],
          meditationTints: [
            Color(0xFF1C4F2A),
            Color(0xFF235C33),
            Color(0xFF2D6D3D),
            Color(0xFF3C814B),
            Color(0xFF2A5A35),
            Color(0xFF478D56),
            Color(0xFF174524),
            Color(0xFF356E43),
            Color(0xFF4D9360),
            Color(0xFF255134),
          ],
        );
      case AuraTheme.innerFire:
        return const AuraPalette(
          primary: Color(0xFFE36D1D),
          primaryDark: Color(0xFFB44A0D),
          accent: Color(0xFFFFB15E),
          surface: Color(0xFF462215),
          scaffoldBackground: Color(0xFF2E150C),
          card: Color(0xFF5A2A18),
          textMuted: Color(0xB3FFF3E0),
          premiumBadge: Color(0xFFFFC857),
          glass: Color(0x22FFFFFF),
          glassBorder: Color(0x33FFD7A3),
          backgroundGradient: [
            Color(0xFF8E3A0A),
            Color(0xFF70280C),
            Color(0xFF45180A),
          ],
          heroGradient: [Color(0xFFFFB15E), Color(0xFFE36D1D)],
          buttonGradient: [Color(0xFFFFB15E), Color(0xFFE36D1D)],
          meditationTints: [
            Color(0xFF7C3504),
            Color(0xFF8E3F08),
            Color(0xFFA24D0D),
            Color(0xFFB85A12),
            Color(0xFF8A420A),
            Color(0xFFC4691B),
            Color(0xFF6E2E03),
            Color(0xFF9C4B0C),
            Color(0xFFB96316),
            Color(0xFF7A3607),
          ],
        );
      case AuraTheme.sunsetGlow:
        return const AuraPalette(
          primary: Color(0xFFC7722E),
          primaryDark: Color(0xFF8A4A1F),
          accent: Color(0xFFFFC17D),
          surface: Color(0xFF482616),
          scaffoldBackground: Color(0xFF321B0E),
          card: Color(0xFF5E341E),
          textMuted: Color(0xB3FFE8D6),
          premiumBadge: Color(0xFFFFD068),
          glass: Color(0x20FFFFFF),
          glassBorder: Color(0x33FFD0AE),
          backgroundGradient: [
            Color(0xFF9F4E20),
            Color(0xFF7A3C22),
            Color(0xFF4E2818),
          ],
          heroGradient: [Color(0xFFFFC17D), Color(0xFFC7722E)],
          buttonGradient: [Color(0xFFFFC17D), Color(0xFFC7722E)],
          meditationTints: [
            Color(0xFF6A3520),
            Color(0xFF7A4024),
            Color(0xFF8D4C2B),
            Color(0xFFA05A34),
            Color(0xFF7D4227),
            Color(0xFFB26A3D),
            Color(0xFF5C2D1A),
            Color(0xFF8C5130),
            Color(0xFFAA6440),
            Color(0xFF6F3922),
          ],
        );
      case AuraTheme.oceanDeep:
        return const AuraPalette(
          primary: Color(0xFF1D5D82),
          primaryDark: Color(0xFF143F59),
          accent: Color(0xFF66B3D6),
          surface: Color(0xFF153345),
          scaffoldBackground: Color(0xFF0F2333),
          card: Color(0xFF1C475E),
          textMuted: Color(0xB3E1F5FE),
          premiumBadge: Color(0xFFFFD700),
          glass: Color(0x1FFFFFFF),
          glassBorder: Color(0x3366B3D6),
          backgroundGradient: [
            Color(0xFF1E6080),
            Color(0xFF184C68),
            Color(0xFF0E2E42),
          ],
          heroGradient: [Color(0xFF66B3D6), Color(0xFF1D5D82)],
          buttonGradient: [Color(0xFF66B3D6), Color(0xFF1D5D82)],
          meditationTints: [
            Color(0xFF14455E),
            Color(0xFF19506E),
            Color(0xFF1F5F83),
            Color(0xFF2A739A),
            Color(0xFF1A526D),
            Color(0xFF3284AE),
            Color(0xFF103B52),
            Color(0xFF236888),
            Color(0xFF2F7B9F),
            Color(0xFF17485F),
          ],
        );
      case AuraTheme.lavenderDream:
        return const AuraPalette(
          primary: Color(0xFF6C4A8A),
          primaryDark: Color(0xFF4E3567),
          accent: Color(0xFFB196D6),
          surface: Color(0xFF2A2046),
          scaffoldBackground: Color(0xFF1D1735),
          card: Color(0xFF372A56),
          textMuted: Color(0xB3F3E5F5),
          premiumBadge: Color(0xFFFFD700),
          glass: Color(0x22FFFFFF),
          glassBorder: Color(0x33D1BCE5),
          backgroundGradient: [
            Color(0xFF6B4A88),
            Color(0xFF563A6E),
            Color(0xFF36264C),
          ],
          heroGradient: [Color(0xFFB196D6), Color(0xFF6C4A8A)],
          buttonGradient: [Color(0xFFB196D6), Color(0xFF6C4A8A)],
          meditationTints: [
            Color(0xFF4C3360),
            Color(0xFF5B3E74),
            Color(0xFF6B4A8A),
            Color(0xFF7D5CA1),
            Color(0xFF5D406F),
            Color(0xFF8C6DB3),
            Color(0xFF422D55),
            Color(0xFF705090),
            Color(0xFF8565AB),
            Color(0xFF54396A),
          ],
        );
    }
  }
}

ThemeData buildAuraTheme(AuraTheme aura) {
  final palette = aura.palette;
  final scheme = ColorScheme.fromSeed(
    seedColor: palette.primary,
    brightness: Brightness.dark,
    primary: palette.primary,
    secondary: palette.accent,
    surface: palette.surface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: palette.scaffoldBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: palette.primaryDark,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: palette.surface,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    dividerColor: palette.glassBorder,
    cardColor: palette.card,
    textTheme: const TextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    extensions: <ThemeExtension<dynamic>>[palette],
  );
}

extension AuraPaletteContext on BuildContext {
  AuraPalette get aura {
    final palette = Theme.of(this).extension<AuraPalette>();
    if (palette != null) {
      return palette;
    }
    return AuraTheme.deepMind.palette;
  }

  LinearGradient get auraBackgroundGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: aura.backgroundGradient,
    );
  }

  LinearGradient get auraButtonGradient {
    return LinearGradient(colors: aura.buttonGradient);
  }
}
