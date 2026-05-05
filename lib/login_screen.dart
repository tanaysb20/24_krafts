import 'package:flutter/material.dart';

import 'krafts_design.dart';
import 'responsive.dart';
import 'verify_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isArtist = true;
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return Scaffold(
      backgroundColor: KraftsColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: KraftsLayout.screenPaddingFor(context).copyWith(
                top: KraftsSpacing.md * s,
                bottom: KraftsSpacing.lg * s,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroIllustration(
                    width: constraints.maxWidth,
                    isArtist: _isArtist,
                  ),
                  SizedBox(height: KraftsSpacing.lg * s),
                  Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: KraftsTextStyles.welcomeHeadline(context: context),
                  ),
                  SizedBox(height: KraftsSpacing.sm * s),
                  Text(
                    'Enter your mobile number to continue',
                    textAlign: TextAlign.center,
                    style: KraftsTextStyles.subtitle(context: context),
                  ),
                  SizedBox(height: KraftsSpacing.lg * s),
                  _RoleTabs(
                    isArtist: _isArtist,
                    onArtist: () => setState(() => _isArtist = true),
                    onRecruiter: () => setState(() => _isArtist = false),
                  ),
                  SizedBox(height: KraftsSpacing.lg * s),
                  Text(
                    'Mobile Number',
                    style: KraftsTextStyles.fieldLabel(context: context),
                  ),
                  SizedBox(height: KraftsSpacing.sm * s),
                  _PhoneField(controller: _phoneController),
                  SizedBox(height: KraftsSpacing.lg * s),
                  _SendOtpButton(
                    onPressed: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (context) => VerifyOtpScreen(
                            phone: _phoneController.text.trim(),
                            isRecruiter: !_isArtist,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: (constraints.maxHeight * 0.06).clamp(24.0, 48.0),
                  ),
                  _SignUpFooter(onSignUp: () {}),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  const _HeroIllustration({required this.width, required this.isArtist});

  final double width;
  final bool isArtist;

  static const _artistHero = 'assets/images/login_hero.png';
  static const _recruiterHero = 'assets/images/login_hero_recruiter.png';

  @override
  Widget build(BuildContext context) {
    final w = width - KraftsSpacing.lg * 2;
    final h = (w / KraftsLayout.heroAspectHint).clamp(200.0, 400.0);
    final asset = isArtist ? _artistHero : _recruiterHero;
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

class _RoleTabs extends StatelessWidget {
  const _RoleTabs({
    required this.isArtist,
    required this.onArtist,
    required this.onRecruiter,
  });

  final bool isArtist;
  final VoidCallback onArtist;
  final VoidCallback onRecruiter;

  @override
  Widget build(BuildContext context) {
    final gap = context.rs(KraftsSpacing.xl);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RoleTab(label: 'Artist', selected: isArtist, onTap: onArtist),
        SizedBox(width: gap),
        _RoleTab(label: 'Recruiter', selected: !isArtist, onTap: onRecruiter),
      ],
    );
  }
}

class _RoleTab extends StatelessWidget {
  const _RoleTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(KraftsSpacing.sm * s),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: KraftsSpacing.sm * s,
          vertical: KraftsSpacing.xs * s,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Container(
                width: KraftsRadius.roleCheck * 2 * s,
                height: KraftsRadius.roleCheck * 2 * s,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: KraftsColors.white,
                  border: Border.all(
                    color: KraftsColors.primaryPurple,
                    width: 1.5,
                  ),
                ),
                child: Icon(Icons.check, size: 14 * s, color: Colors.black87),
              ),
              SizedBox(width: KraftsSpacing.sm * s),
            ],
            Text(
              label,
              style: selected
                  ? KraftsTextStyles.roleSelected()
                  : KraftsTextStyles.roleUnselected(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});

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
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: KraftsSpacing.md * s,
              top: KraftsSpacing.md * s,
              bottom: KraftsSpacing.md * s,
            ),
            child: Text(
              '+91',
              style: KraftsTextStyles.countryCode(context: context),
            ),
          ),
          Container(
            width: 1,
            height: 24 * s,
            margin: EdgeInsets.symmetric(horizontal: KraftsSpacing.sm * s),
            color: KraftsColors.inputBorder,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: KraftsTextStyles.phoneInput(context: context),
              decoration: InputDecoration(
                hintText: '(555) 000-0000',
                hintStyle: KraftsTextStyles.phoneHint(context: context),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.only(
                  right: KraftsSpacing.md * s,
                  top: KraftsSpacing.md * s,
                  bottom: KraftsSpacing.md * s,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SendOtpButton extends StatelessWidget {
  const _SendOtpButton({required this.onPressed});

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
            KraftsColors.purpleDeep,
            KraftsColors.primaryPurple,
            KraftsColors.purpleLight,
          ],
          stops: [0.0, 0.45, 1.0],
        ),
        borderRadius: BorderRadius.circular(KraftsRadius.button * s),
        boxShadow: [
          BoxShadow(
            color: KraftsColors.primaryPurple.withValues(alpha: 0.38),
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
                'Send OTP',
                style: KraftsTextStyles.primaryButton(context: context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpFooter extends StatelessWidget {
  const _SignUpFooter({required this.onSignUp});

  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: KraftsTextStyles.footer(context: context),
          ),
          GestureDetector(
            onTap: onSignUp,
            child: Text(
              'Sign up',
              style: KraftsTextStyles.footerLink(context: context),
            ),
          ),
        ],
      ),
    );
  }
}
