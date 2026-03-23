import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF5C35B5);
  static const Color primaryDark = Color(0xFF3D1F8F);
  static const Color accent = Color(0xFF8B6BE8);
  static const Color surface = Color(0xFF1A1033);
  static const Color scaffoldBg = Color(0xFF0F0A1E);
  static const Color cardBg = Color(0xFF231748);
  static const Color premiumBadge = Color(0xFFFFD700);

  static const LinearGradient paywallGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D1065), Color(0xFF1A0B3B), Color(0xFF0D0621)],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF8B6BE8), Color(0xFF5C35B5)],
  );

  static const List<Color> cardTints = [
    Color(0xFF4A3080),
    Color(0xFF1E5F6B),
    Color(0xFF5F2E5F),
    Color(0xFF2E5F3C),
    Color(0xFF5F4A1E),
    Color(0xFF1E3A5F),
    Color(0xFF5F1E2E),
    Color(0xFF2E4A5F),
    Color(0xFF4A5F1E),
    Color(0xFF5F3D1E),
  ];
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

enum DeviceClass { phone, tablet, desktop, tv }

double screenScale(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  return (width / 390.0).clamp(0.75, 1.2);
}

double sp(BuildContext context, double size) => size * screenScale(context);

DeviceClass deviceClassFromWidth(double width) {
  if (width >= 1300) return DeviceClass.tv;
  if (width >= 1000) return DeviceClass.desktop;
  if (width >= 700) return DeviceClass.tablet;
  return DeviceClass.phone;
}

DeviceClass deviceClassOf(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  return deviceClassFromWidth(width);
}

bool isPhone(BuildContext context) =>
    deviceClassOf(context) == DeviceClass.phone;

bool isTablet(BuildContext context) =>
    deviceClassOf(context) == DeviceClass.tablet;

bool isDesktopLike(BuildContext context) {
  final kind = deviceClassOf(context);
  return kind == DeviceClass.desktop || kind == DeviceClass.tv;
}

double responsiveMaxContentWidth(BuildContext context) {
  switch (deviceClassOf(context)) {
    case DeviceClass.phone:
      return double.infinity;
    case DeviceClass.tablet:
      return 760;
    case DeviceClass.desktop:
      return 980;
    case DeviceClass.tv:
      return 1180;
  }
}

int meditationGridColumns(BuildContext context) {
  switch (deviceClassOf(context)) {
    case DeviceClass.phone:
      return 1;
    case DeviceClass.tablet:
      return 2;
    case DeviceClass.desktop:
      return 3;
    case DeviceClass.tv:
      return 4;
  }
}
