import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'complete_profile_screen.dart';
import 'krafts_design.dart';
import 'responsive.dart';

/// OTP verification step — after [LoginScreen] “Send OTP”.
///
/// Figma: https://www.figma.com/design/RoBxclHMsmzXWhQAHmE69v/24-Crafts?node-id=0-1
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    super.key,
    required this.phone,
    this.isRecruiter = false,
  });

  final String phone;
  final bool isRecruiter;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return Scaffold(
      backgroundColor: KraftsColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: KraftsLayout.screenPaddingFor(context).copyWith(
                top: KraftsSpacing.xs * s,
                bottom: KraftsSpacing.sm * s,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _RoundBackButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: KraftsLayout.screenPaddingFor(
                      context,
                    ).copyWith(bottom: KraftsSpacing.lg * s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _VerifyHeroIllustration(
                          width: constraints.maxWidth,
                          isRecruiter: widget.isRecruiter,
                        ),
                        SizedBox(height: KraftsSpacing.lg * s),
                        Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: KraftsTextStyles.welcomeHeadline(
                            context: context,
                          ),
                        ),
                        SizedBox(height: KraftsSpacing.sm * s),
                        Text(
                          'Enter your mobile number to continue',
                          textAlign: TextAlign.center,
                          style: KraftsTextStyles.subtitle(context: context),
                        ),
                        SizedBox(height: KraftsSpacing.lg * s),
                        Text(
                          'Mobile Number',
                          style: KraftsTextStyles.fieldLabel(context: context),
                        ),
                        SizedBox(height: KraftsSpacing.sm * s),
                        _OtpField(controller: _otpController),
                        SizedBox(height: KraftsSpacing.lg * s),
                        _VerifyOtpButton(
                          onPressed: () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (context) => CompleteProfileScreen(
                                  phone: widget.phone,
                                  isRecruiter: widget.isRecruiter,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundBackButton extends StatelessWidget {
  const _RoundBackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return Material(
      color: KraftsColors.white,
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(12 * s),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: KraftsColors.backIcon,
          ),
        ),
      ),
    );
  }
}

class _VerifyHeroIllustration extends StatelessWidget {
  const _VerifyHeroIllustration({
    required this.width,
    required this.isRecruiter,
  });

  final double width;
  final bool isRecruiter;

  static const _artistHero = 'assets/images/verify_otp_hero.png';
  static const _recruiterHero = 'assets/images/login_hero_recruiter.png';

  @override
  Widget build(BuildContext context) {
    final w = width;
    final h = (w / KraftsLayout.heroAspectHint).clamp(200.0, 400.0);
    final asset = isRecruiter ? _recruiterHero : _artistHero;
    return ClipRRect(
      borderRadius: BorderRadius.circular(KraftsRadius.hero),
      child: SizedBox(
        width: double.infinity,
        height: h,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: ColoredBox(
            key: ValueKey<String>(asset),
            color: KraftsColors.inputFill,
            child: Image.asset(
              asset,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  const _OtpField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return Container(
      decoration: BoxDecoration(
        color: KraftsColors.inputFill,
        borderRadius: BorderRadius.circular(KraftsRadius.field * s),
        border: Border.all(color: KraftsColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        style: KraftsTextStyles.phoneInput(context: context),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'XXXXXX',
          hintStyle: KraftsTextStyles.phoneHint(context: context),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: KraftsSpacing.md * s,
            vertical: KraftsSpacing.md * s,
          ),
        ),
      ),
    );
  }
}

class _VerifyOtpButton extends StatelessWidget {
  const _VerifyOtpButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            KraftsColors.purpleVerifyDeep,
            KraftsColors.purpleVerify,
            KraftsColors.purpleVerifyLight,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(KraftsRadius.button * s),
        boxShadow: [
          BoxShadow(
            color: KraftsColors.purpleVerify.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(KraftsRadius.button * s),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: KraftsSpacing.md * s),
            child: Center(
              child: Text(
                'Verify OTP',
                style: KraftsTextStyles.primaryButton(context: context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
