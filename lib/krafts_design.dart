import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'responsive.dart';

/// **24 Crafts** login — align with Figma Dev Mode.
///
/// https://www.figma.com/design/RoBxclHMsmzXWhQAHmE69v/24-Crafts?node-id=0-1
abstract final class KraftsColors {
  static const Color primaryPurple = Color(0xFF9D44F0);
  static const Color purpleDeep = Color(0xFF7C3AED);
  static const Color purpleLight = Color(0xFFB77BFF);

  /// Primary actions on the OTP / verify step (Figma ~`#9333ea`).
  static const Color purpleVerify = Color(0xFF9333EA);
  static const Color purpleVerifyDeep = Color(0xFF7E22CE);
  static const Color purpleVerifyLight = Color(0xFFA855F7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color headline = Color(0xFF111827);
  static const Color subtitle = Color(0xFF6B7280);
  static const Color label = Color(0xFF374151);
  static const Color roleMuted = Color(0xFF9CA3AF);
  static const Color inputFill = Color(0xFFF3F4F6);
  static const Color inputBorder = Color(0xFFE5E7EB);
  static const Color hint = Color(0xFF9CA3AF);
  static const Color backIcon = Color(0xFF4B5563);
  static const Color requiredStar = Color(0xFFDC2626);
  static const Color draftButtonBg = Color(0xFFE5E7EB);
  static const Color draftButtonText = Color(0xFF374151);
  static const Color linkAction = Color(0xFF2563EB);
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color twitterBlue = Color(0xFF1DA1F2);
  static const Color linkedInBlue = Color(0xFF0A66C2);

  /// Aadhaar / KYC step (Figma node 15-604).
  static const Color kycHeaderPurple = Color(0xFF9333EA);
  static const Color infoCardBlueBg = Color(0xFFEFF6FF);
  static const Color infoCardBlueBorder = Color(0xFF93C5FD);
  static const Color infoTitleBlue = Color(0xFF1E40AF);
  static const Color infoBodyBlue = Color(0xFF3B82F6);
  static const Color consentBoxBg = Color(0xFFF9FAFB);
  static const Color aadhaarButtonLavender = Color(0xFFC4B5FD);
  static const Color aadhaarButtonLavenderEnd = Color(0xFFA78BFA);
  static const Color sslBadgeGreen = Color(0xFF22C55E);
  static const Color uidaiBadgeBlue = Color(0xFF2563EB);

  /// Producer / recruiter home (Figma node 15-892).
  static const Color dashboardPurple = Color(0xFF8A33FD);
  static const Color favoriteBlue = Color(0xFFDBEAFE);
  static const Color favoritePurple = Color(0xFFE9D5FF);
  static const Color favoriteOrange = Color(0xFFFFE4CC);
  static const Color bannerDark = Color(0xFF1E1B4B);
  static const Color statusGreen = Color(0xFF22C55E);
  static const Color statusBlue = Color(0xFF3B82F6);
  static const Color statusAmber = Color(0xFFEAB308);
}

abstract final class KraftsSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

abstract final class KraftsRadius {
  static const double hero = 32;
  static const double field = 16;
  static const double button = 16;
  static const double roleCheck = 11;
}

abstract final class KraftsLayout {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: KraftsSpacing.lg,
  );

  static EdgeInsets screenPaddingFor(BuildContext context) {
    final h = KraftsSpacing.lg * context.scale;
    return EdgeInsets.symmetric(horizontal: h);
  }

  /// Slightly taller card so the hero art + banner title read comfortably.
  static const double heroAspectHint = 1.05;
}

abstract final class KraftsTextStyles {
  static double _scaled(BuildContext? context, double size) {
    if (context == null) return size;
    return size * context.scale;
  }

  /// White title on the purple hero art (“Your Next Cinematic Adventure!”).
  static TextStyle heroBannerTitle({BuildContext? context}) =>
      GoogleFonts.inter(
        fontSize: _scaled(context, 14),
        fontWeight: FontWeight.w800,
        color: KraftsColors.white,
        height: 1.25,
        letterSpacing: 0.2,
        shadows: const [
          Shadow(
            color: Color(0x66000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      );

  static TextStyle welcomeHeadline({BuildContext? context}) =>
      GoogleFonts.inter(
        fontSize: _scaled(context, 28),
        fontWeight: FontWeight.w700,
        color: KraftsColors.headline,
        height: 1.2,
      );

  static TextStyle subtitle({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 15),
    fontWeight: FontWeight.w500,
    color: KraftsColors.subtitle,
    height: 1.35,
  );

  static TextStyle fieldLabel({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 13),
    fontWeight: FontWeight.w600,
    color: KraftsColors.label,
    height: 1.2,
  );

  static TextStyle roleSelected({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 16),
    fontWeight: FontWeight.w700,
    color: KraftsColors.primaryPurple,
    height: 1.2,
  );

  static TextStyle roleUnselected({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 16),
    fontWeight: FontWeight.w500,
    color: KraftsColors.roleMuted,
    height: 1.2,
  );

  static TextStyle phoneInput({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 16),
    fontWeight: FontWeight.w500,
    color: KraftsColors.headline,
    height: 1.25,
  );

  static TextStyle phoneHint({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 16),
    fontWeight: FontWeight.w500,
    color: KraftsColors.hint,
    height: 1.25,
  );

  static TextStyle countryCode({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 16),
    fontWeight: FontWeight.w600,
    color: KraftsColors.headline,
    height: 1.25,
  );

  static TextStyle primaryButton({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 17),
    fontWeight: FontWeight.w700,
    color: KraftsColors.white,
    letterSpacing: 0.2,
    height: 1.2,
  );

  static TextStyle footer({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 15),
    fontWeight: FontWeight.w400,
    color: KraftsColors.subtitle,
    height: 1.35,
  );

  static TextStyle footerLink({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 15),
    fontWeight: FontWeight.w600,
    color: KraftsColors.primaryPurple,
    height: 1.35,
  );

  static TextStyle sectionTitle({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 18),
    fontWeight: FontWeight.w700,
    color: KraftsColors.headline,
    height: 1.2,
  );

  static TextStyle draftButton({BuildContext? context}) => GoogleFonts.inter(
    fontSize: _scaled(context, 16),
    fontWeight: FontWeight.w600,
    color: KraftsColors.draftButtonText,
    height: 1.2,
  );
}
