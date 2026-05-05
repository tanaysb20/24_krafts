import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'krafts_design.dart';
import 'producer_dashboard_screen.dart';

/// Aadhaar verification — KYC step 2 of 2, after [CompleteProfileScreen].
///
/// Figma: https://www.figma.com/design/RoBxclHMsmzXWhQAHmE69v/24-Crafts?node-id=15-604
class AadhaarVerificationScreen extends StatefulWidget {
  const AadhaarVerificationScreen({super.key, this.isRecruiter = false});

  final bool isRecruiter;

  @override
  State<AadhaarVerificationScreen> createState() =>
      _AadhaarVerificationScreenState();
}

class _AadhaarDigitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final t = digits.length > 12 ? digits.substring(0, 12) : digits;
    final buf = StringBuffer();
    for (var i = 0; i < t.length; i++) {
      if (i > 0 && i % 4 == 0) buf.write(' ');
      buf.write(t[i]);
    }
    final text = buf.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  final _aadhaarController = TextEditingController();
  bool _consentUidai = false;
  bool _consentTerms = false;

  late final TapGestureRecognizer _termsTap;
  late final TapGestureRecognizer _privacyTap;

  @override
  void initState() {
    super.initState();
    _termsTap = TapGestureRecognizer()
      ..onTap = () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Terms & Conditions')));
      };
    _privacyTap = TapGestureRecognizer()
      ..onTap = () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Privacy Policy')));
      };
  }

  @override
  void dispose() {
    _aadhaarController.dispose();
    _termsTap.dispose();
    _privacyTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KraftsColors.white,
      appBar: AppBar(
        backgroundColor: KraftsColors.white,
        foregroundColor: KraftsColors.headline,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Aadhaar Verification',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: KraftsColors.headline,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          KraftsSpacing.lg,
          0,
          KraftsSpacing.lg,
          KraftsSpacing.xl,
        ),
        children: [
          _KycProgressHeader(),
          const SizedBox(height: KraftsSpacing.lg),
          _InfoCard(),
          const SizedBox(height: KraftsSpacing.lg),
          Text('Aadhaar Number', style: KraftsTextStyles.fieldLabel()),
          const SizedBox(height: KraftsSpacing.sm),
          TextField(
            controller: _aadhaarController,
            keyboardType: TextInputType.number,
            inputFormatters: [_AadhaarDigitFormatter()],
            style: KraftsTextStyles.phoneInput(),
            decoration: InputDecoration(
              hintText: '1234 5678 9012',
              hintStyle: KraftsTextStyles.phoneHint(),
              filled: true,
              fillColor: KraftsColors.white,
              suffixIcon: const Icon(
                Icons.badge_outlined,
                color: KraftsColors.roleMuted,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: KraftsSpacing.md,
                vertical: KraftsSpacing.md,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KraftsRadius.field),
                borderSide: const BorderSide(color: KraftsColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KraftsRadius.field),
                borderSide: const BorderSide(color: KraftsColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(KraftsRadius.field),
                borderSide: const BorderSide(
                  color: KraftsColors.purpleVerify,
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: KraftsSpacing.xs),
          Text(
            'Enter your 12-digit Aadhaar number',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: KraftsColors.roleMuted,
            ),
          ),
          const SizedBox(height: KraftsSpacing.lg),
          _ConsentSection(
            consentUidai: _consentUidai,
            consentTerms: _consentTerms,
            onUidaiChanged: (v) => setState(() => _consentUidai = v ?? false),
            onTermsChanged: (v) => setState(() => _consentTerms = v ?? false),
            termsTap: _termsTap,
            privacyTap: _privacyTap,
          ),
          const SizedBox(height: KraftsSpacing.lg),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  KraftsColors.aadhaarButtonLavender,
                  KraftsColors.aadhaarButtonLavenderEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(KraftsRadius.button),
              boxShadow: [
                BoxShadow(
                  color: KraftsColors.purpleVerify.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // if (!widget.isRecruiter) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Artist home — connect after KYC'),
                  //     ),
                  //   );
                  //   return;
                  // }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (context) => ProducerDashboardScreen(
                        isRecruiter: widget.isRecruiter,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(KraftsRadius.button),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: KraftsSpacing.md,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified_user_rounded,
                        color: KraftsColors.white,
                        size: 22,
                      ),
                      const SizedBox(width: KraftsSpacing.sm),
                      Text(
                        'Verify Aadhaar',
                        style: KraftsTextStyles.primaryButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: KraftsSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _TrustBadge(
                  icon: Icons.lock_rounded,
                  iconColor: KraftsColors.sslBadgeGreen,
                  title: '256-bit SSL',
                  subtitle: 'Encrypted',
                ),
              ),
              const SizedBox(width: KraftsSpacing.md),
              Expanded(
                child: _TrustBadge(
                  icon: Icons.verified_rounded,
                  iconColor: KraftsColors.uidaiBadgeBlue,
                  title: 'UIDAI Verified',
                  subtitle: 'Authentic',
                ),
              ),
            ],
          ),
          const SizedBox(height: KraftsSpacing.lg),
          _HelpCard(),
          const SizedBox(height: KraftsSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shield_rounded,
                size: 16,
                color: KraftsColors.sslBadgeGreen,
              ),
              const SizedBox(width: KraftsSpacing.xs),
              Text(
                'Secured by 256-bit SSL encryption',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: KraftsColors.subtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KycProgressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KraftsSpacing.lg),
      decoration: BoxDecoration(
        color: KraftsColors.kycHeaderPurple,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.credit_card_rounded,
                  color: KraftsColors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: KraftsSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KYC Verification',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: KraftsColors.white,
                      ),
                    ),
                    Text(
                      'Step 2 of 2',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: KraftsSpacing.md),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: KraftsColors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: KraftsSpacing.sm),
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KraftsSpacing.md),
      decoration: BoxDecoration(
        color: KraftsColors.infoCardBlueBg,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        border: Border.all(color: KraftsColors.infoCardBlueBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: KraftsColors.infoTitleBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: KraftsSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aadhaar Information',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: KraftsColors.infoTitleBlue,
                  ),
                ),
                const SizedBox(height: KraftsSpacing.xs),
                Text(
                  "Enter your 12-digit Aadhaar number. We'll send an OTP to your registered mobile number for verification.",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    color: KraftsColors.infoBodyBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsentSection extends StatelessWidget {
  const _ConsentSection({
    required this.consentUidai,
    required this.consentTerms,
    required this.onUidaiChanged,
    required this.onTermsChanged,
    required this.termsTap,
    required this.privacyTap,
  });

  final bool consentUidai;
  final bool consentTerms;
  final ValueChanged<bool?> onUidaiChanged;
  final ValueChanged<bool?> onTermsChanged;
  final TapGestureRecognizer termsTap;
  final TapGestureRecognizer privacyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KraftsSpacing.md),
      decoration: BoxDecoration(
        color: KraftsColors.consentBoxBg,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        border: Border.all(color: KraftsColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: consentUidai,
                  onChanged: onUidaiChanged,
                  activeColor: KraftsColors.purpleVerify,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: KraftsSpacing.sm),
              Expanded(
                child: Text(
                  'I hereby give my consent to fetch my KYC information from UIDAI for the purpose of account verification and compliance with regulatory requirements.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    color: KraftsColors.label,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: KraftsSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: consentTerms,
                  onChanged: onTermsChanged,
                  activeColor: KraftsColors.purpleVerify,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: KraftsSpacing.sm),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: KraftsColors.label,
                    ),
                    children: [
                      const TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: const TextStyle(
                          color: KraftsColors.linkAction,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: termsTap,
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: KraftsColors.linkAction,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: privacyTap,
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KraftsSpacing.md),
      decoration: BoxDecoration(
        color: KraftsColors.white,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        border: Border.all(color: KraftsColors.inputBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: KraftsSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: KraftsColors.headline,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: KraftsColors.subtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget row(IconData icon, String label) {
      return InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(label)));
        },
        borderRadius: BorderRadius.circular(KraftsSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 22, color: KraftsColors.subtitle),
              const SizedBox(width: KraftsSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: KraftsColors.headline,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: KraftsColors.roleMuted),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(KraftsSpacing.md),
      decoration: BoxDecoration(
        color: KraftsColors.white,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        border: Border.all(color: KraftsColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Need Help?',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: KraftsColors.headline,
                ),
              ),
              const SizedBox(width: KraftsSpacing.xs),
              Icon(
                Icons.help_outline_rounded,
                size: 20,
                color: KraftsColors.roleMuted,
              ),
            ],
          ),
          const Divider(height: KraftsSpacing.lg),
          row(Icons.phone_rounded, 'Call Customer Support'),
          row(Icons.chat_bubble_outline_rounded, 'Chat with Agent'),
          row(Icons.article_outlined, 'View FAQ'),
        ],
      ),
    );
  }
}
