// free-task — Design tokens → Flutter ThemeData
// claude-v1 · Quiet Productivity
//
// Kaynak: docs/design/claude-v1/design-summary.md §9 (Design tokens).
// Bu dosya tasarım token'larının birebir Flutter karşılığıdır. Renkler semantik
// isimlerle FtColors içinde; light/dark iki ColorScheme + ThemeData üretir.
// Tek token seti, iki tema haritası — layout/spacing/radius sabittir.
//
// Not: Fontlar (Hanken Grotesk + IBM Plex Mono) pubspec.yaml'a eklenmeli veya
// google_fonts ile yüklenmeli. Aşağıda fontFamily string'leri varsayılan olarak
// 'Hanken Grotesk' / 'IBM Plex Mono' bekler.

import 'package:flutter/material.dart';

/// Ham renk token'ları (design-summary §9.1). Faz renkleri de dahil.
class FtColors {
  FtColors._();

  // ---- LIGHT ----
  static const bg            = Color(0xFFFAF9F6); // ekran zemini
  static const surface       = Color(0xFFFFFFFF); // kart, satır
  static const surfaceSunken = Color(0xFFF1EFEA); // segment yuvası, input
  static const ink1          = Color(0xFF26231F); // birincil metin
  static const ink2          = Color(0xFF6A645C); // ikincil metin
  static const ink3          = Color(0xFF9C958B); // placeholder, pasif
  static const border        = Color(0xFFE6E2DA); // kart/divider
  static const borderInner   = Color(0xFFF1EFEA); // kart içi ayrım
  static const primary       = Color(0xFF2C7D6D); // aksiyon, tamamlama
  static const primaryTint   = Color(0xFFE4F1ED); // primary zemin
  static const warning       = Color(0xFFB7791F); // deadline yaklaşıyor
  static const danger        = Color(0xFFB4442F); // yüksek öncelik, hata

  // ---- DARK ----
  static const bgDark            = Color(0xFF1B1815);
  static const surfaceDark       = Color(0xFF242019);
  static const surfaceSunkenDark = Color(0xFF151310);
  static const ink1Dark          = Color(0xFFECE8E1);
  static const ink2Dark          = Color(0xFFABA398);
  static const ink3Dark          = Color(0xFF6F6A61);
  static const borderDark        = Color(0xFF34302A);
  static const borderInnerDark   = Color(0xFF2E2A23);
  static const primaryDark       = Color(0xFF4FB39A);
  static const primaryTintDark   = Color(0xFF17332C);
  static const warningDark       = Color(0xFFD9A441);
  static const dangerDark        = Color(0xFFD9694F);

  // ---- ÖNCELİK (design-summary §9.1) ----
  static const priHigh   = Color(0xFFB4442F); // P1
  static const priMed    = Color(0xFFB7791F); // P2
  static const priLow    = Color(0xFF9C958B); // P3
  static const priHighDark = Color(0xFFD9694F);
  static const priMedDark  = Color(0xFFD9A441);
  static const priLowDark  = Color(0xFF8F877C);

  // ---- FAZ AKSANLARI ----
  static const faz2       = Color(0xFFB7791F); // Faz 2 · amber (sync & ekip)
  static const faz3       = Color(0xFF6D5AB7); // Faz 3 · mor (AI & platform)
  static const faz3Bright = Color(0xFF8878C9); // Faz 3 · dark aksan
  static const faz3Tint   = Color(0xFFECE8F6);

  // ---- ÜYE / ROL AVATAR RENKLERİ (Faz 2) ----
  static const roleOwner  = primary;          // sahip
  static const roleAdmin  = Color(0xFFB7791F); // yönetici
  static const roleMember = Color(0xFF4C3E8A); // üye
  static const roleViewer = Color(0xFF9C958B); // izleyici
}

/// Spacing ölçeği — 4px tabanı (design-summary §9.3).
class FtSpacing {
  FtSpacing._();
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x8 = 32;

  static const double screenPadding = 20; // 18–22 arası
  static const double cardGap = 8;
  static const double sectionGap = 16;
}

/// Radius ölçeği (design-summary §9.4).
class FtRadius {
  FtRadius._();
  static const double chip   = 6;   // küçük çip / checkbox
  static const double control = 12; // input, satır, buton (10–12)
  static const double card   = 14;
  static const double fab    = 16;
  static const double sheet  = 26;  // bottom sheet üst köşe
  static const double device = 40;

  static BorderRadius get cardR => BorderRadius.circular(card);
  static BorderRadius get controlR => BorderRadius.circular(control);
  static BorderRadius get sheetTop =>
      const BorderRadius.vertical(top: Radius.circular(sheet));
}

/// Elevation / shadow (design-summary §9.5). Hiyerarşi önce border + zemin.
class FtElevation {
  FtElevation._();
  static const List<BoxShadow> e1 = [
    BoxShadow(color: Color(0x14000000), blurRadius: 3, offset: Offset(0, 1)),
  ];
  static const List<BoxShadow> e2Fab = [
    BoxShadow(color: Color(0x992C7D6D), blurRadius: 18, offset: Offset(0, 8), spreadRadius: -6),
  ];
  static const List<BoxShadow> e3Sheet = [
    BoxShadow(color: Color(0x4D000000), blurRadius: 40, offset: Offset(0, -12), spreadRadius: -12),
  ];
}

/// Tipografi ölçeği (design-summary §9.2).
/// Gövde: Hanken Grotesk · Mono/etiket/saat: IBM Plex Mono.
class FtType {
  FtType._();
  static const String sans = 'Hanken Grotesk';
  static const String mono = 'IBM Plex Mono';

  static TextTheme textTheme(Color ink1, Color ink2) => TextTheme(
        displaySmall: TextStyle(fontFamily: sans, fontSize: 28, height: 30 / 28, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: ink1),
        headlineSmall: TextStyle(fontFamily: sans, fontSize: 24, height: 29 / 24, fontWeight: FontWeight.w700, letterSpacing: -0.2, color: ink1),
        titleLarge: TextStyle(fontFamily: sans, fontSize: 20, height: 24 / 20, fontWeight: FontWeight.w700, color: ink1),
        bodyLarge: TextStyle(fontFamily: sans, fontSize: 15, height: 22 / 15, fontWeight: FontWeight.w500, color: ink1),
        bodyMedium: TextStyle(fontFamily: sans, fontSize: 15, height: 22 / 15, fontWeight: FontWeight.w400, color: ink1),
        labelLarge: TextStyle(fontFamily: sans, fontSize: 15, height: 22 / 15, fontWeight: FontWeight.w600, color: ink1),
        bodySmall: TextStyle(fontFamily: sans, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w500, color: ink2),
        // Mono etiket/saat için labelSmall'ı IBM Plex Mono yapıyoruz.
        labelSmall: TextStyle(fontFamily: mono, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w500, letterSpacing: 0.6, color: ink2),
      );
}

/// Light + Dark ThemeData üreticileri.
class FtTheme {
  FtTheme._();

  static ThemeData light() => _build(
        brightness: Brightness.light,
        bg: FtColors.bg,
        surface: FtColors.surface,
        primary: FtColors.primary,
        primaryTint: FtColors.primaryTint,
        error: FtColors.danger,
        border: FtColors.border,
        ink1: FtColors.ink1,
        ink2: FtColors.ink2,
        ink3: FtColors.ink3,
        onPrimary: Colors.white,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        bg: FtColors.bgDark,
        surface: FtColors.surfaceDark,
        primary: FtColors.primaryDark,
        primaryTint: FtColors.primaryTintDark,
        error: FtColors.dangerDark,
        border: FtColors.borderDark,
        ink1: FtColors.ink1Dark,
        ink2: FtColors.ink2Dark,
        ink3: FtColors.ink3Dark,
        onPrimary: const Color(0xFF08221B),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color primary,
    required Color primaryTint,
    required Color error,
    required Color border,
    required Color ink1,
    required Color ink2,
    required Color ink3,
    required Color onPrimary,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryTint,
      onPrimaryContainer: primary,
      secondary: primary,
      onSecondary: onPrimary,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: ink1,
      surfaceContainerHighest: bg,
      onSurfaceVariant: ink2,
      outline: border,
      outlineVariant: border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      colorScheme: scheme,
      textTheme: FtType.textTheme(ink1, ink2),
      dividerColor: border,
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: FtRadius.cardR,
          side: BorderSide(color: border),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: FtRadius.controlR),
          textStyle: const TextStyle(fontFamily: FtType.sans, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      // Dokunma hedefi ≥ 44px (design-summary §10.2).
      materialTapTargetSize: MaterialTapTargetSize.padded,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: FtRadius.sheetTop),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryTint,
        labelStyle: TextStyle(fontFamily: FtType.sans, fontSize: 11, fontWeight: FontWeight.w500, color: primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(FtRadius.chip)),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      ),
    );
  }
}

/// Öncelik rengini brightness'a göre döndüren yardımcı.
Color ftPriorityColor(String priority, Brightness b) {
  final dark = b == Brightness.dark;
  switch (priority) {
    case 'high':
      return dark ? FtColors.priHighDark : FtColors.priHigh;
    case 'med':
      return dark ? FtColors.priMedDark : FtColors.priMed;
    default:
      return dark ? FtColors.priLowDark : FtColors.priLow;
  }
}

/// Kullanım:
///   MaterialApp(
///     theme: FtTheme.light(),
///     darkTheme: FtTheme.dark(),
///     themeMode: ThemeMode.system, // Ayarlar §4.10: Açık/Koyu/Sistem
///   );
