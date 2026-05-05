import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'aadhaar_verification_screen.dart';
import 'krafts_design.dart';

/// “Complete Your Profile” — after [VerifyOtpScreen].
///
/// Figma: https://www.figma.com/design/RoBxclHMsmzXWhQAHmE69v/24-Crafts?node-id=15-378
class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({
    super.key,
    this.phone,
    this.isRecruiter = false,
  });

  final String? phone;
  final bool isRecruiter;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CustomLinkRow {
  _CustomLinkRow()
      : title = TextEditingController(),
        url = TextEditingController();

  final TextEditingController title;
  final TextEditingController url;

  void dispose() {
    title.dispose();
    url.dispose();
  }
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  late final TextEditingController _phone;
  final _altPhone = TextEditingController();
  final _maa = TextEditingController();
  final _companyName = TextEditingController();
  final _companyEmail = TextEditingController();
  final _companyPhone = TextEditingController();
  final _city = TextEditingController();
  final _website = TextEditingController();
  final _facebook = TextEditingController();
  final _twitter = TextEditingController();
  final _linkedin = TextEditingController();

  String? _gender;
  String? _department;
  String? _state;

  final _customLinks = <_CustomLinkRow>[_CustomLinkRow()];

  static const _departments = [
    'Direction',
    'Production',
    'Camera',
    'Art',
    'Post-production',
    'Other',
  ];

  static const _states = [
    'Maharashtra',
    'Karnataka',
    'Delhi',
    'Tamil Nadu',
    'Telangana',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: widget.phone ?? '');
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    _altPhone.dispose();
    _maa.dispose();
    _companyName.dispose();
    _companyEmail.dispose();
    _companyPhone.dispose();
    _city.dispose();
    _website.dispose();
    _facebook.dispose();
    _twitter.dispose();
    _linkedin.dispose();
    for (final row in _customLinks) {
      row.dispose();
    }
    super.dispose();
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: KraftsTextStyles.phoneHint(),
      filled: true,
      fillColor: KraftsColors.white,
      isDense: true,
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
        borderSide: const BorderSide(color: KraftsColors.purpleVerify, width: 1.5),
      ),
    );
  }

  Widget _requiredLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: KraftsSpacing.sm),
      child: RichText(
        text: TextSpan(
          style: KraftsTextStyles.fieldLabel(),
          children: [
            TextSpan(text: text),
            TextSpan(
              text: ' *',
              style: KraftsTextStyles.fieldLabel().copyWith(
                color: KraftsColors.requiredStar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionalLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: KraftsSpacing.sm),
      child: Text(text, style: KraftsTextStyles.fieldLabel()),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: KraftsSpacing.md),
      child: Text(title, style: KraftsTextStyles.sectionTitle()),
    );
  }

  Widget _dropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final decoration = InputDecoration(
      filled: true,
      fillColor: KraftsColors.white,
      isDense: true,
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
        borderSide: const BorderSide(color: KraftsColors.purpleVerify, width: 1.5),
      ),
    );
    return InputDecorator(
      decoration: decoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: KraftsTextStyles.phoneHint()),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map(
                (e) => DropdownMenuItem(value: e, child: Text(e)),
              )
              .toList(),
          onChanged: onChanged,
          style: KraftsTextStyles.phoneInput(),
          dropdownColor: KraftsColors.white,
          borderRadius: BorderRadius.circular(KraftsRadius.field),
        ),
      ),
    );
  }

  void _onPickPlaceholder(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label — connect image picker / file API')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KraftsColors.white,
      appBar: AppBar(
        backgroundColor: KraftsColors.purpleVerify,
        foregroundColor: KraftsColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Complete Your Profile',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: KraftsColors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                KraftsSpacing.lg,
                KraftsSpacing.lg,
                KraftsSpacing.lg,
                KraftsSpacing.md,
              ),
              children: [
                _sectionHeader('Personal Information'),
                _requiredLabel('Full Name'),
                TextField(
                  controller: _fullName,
                  decoration: _decoration('Enter your full name'),
                  style: KraftsTextStyles.phoneInput(),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _requiredLabel('Email ID'),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decoration('your@email.com'),
                  style: KraftsTextStyles.phoneInput(),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _requiredLabel('Phone Number'),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: _decoration('+1 (555) 000-0000'),
                  style: KraftsTextStyles.phoneInput(),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _optionalLabel('Alternate Phone'),
                TextField(
                  controller: _altPhone,
                  keyboardType: TextInputType.phone,
                  decoration: _decoration('+1 (555) 000-0000'),
                  style: KraftsTextStyles.phoneInput(),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _optionalLabel('MAA Association'),
                TextField(
                  controller: _maa,
                  decoration: _decoration('Enter association name'),
                  style: KraftsTextStyles.phoneInput(),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _requiredLabel('Gender'),
                Wrap(
                  spacing: KraftsSpacing.sm,
                  runSpacing: KraftsSpacing.sm,
                  children: [
                    for (final g in ['Male', 'Female', 'Other'])
                      ChoiceChip(
                        label: Text(g, style: KraftsTextStyles.phoneInput()),
                        selected: _gender == g,
                        onSelected: (_) => setState(() => _gender = g),
                        selectedColor:
                            KraftsColors.purpleVerify.withValues(alpha: 0.2),
                        checkmarkColor: KraftsColors.purpleVerify,
                        side: const BorderSide(color: KraftsColors.inputBorder),
                      ),
                  ],
                ),
                const SizedBox(height: KraftsSpacing.md),
                _requiredLabel('Department'),
                _dropdownField(
                  hint: 'Select Department',
                  value: _department,
                  items: _departments,
                  onChanged: (v) => setState(() => _department = v),
                ),
                if (widget.isRecruiter) ...[
                  const SizedBox(height: KraftsSpacing.xl),
                  _sectionHeader('Company Information'),
                  _requiredLabel('Company Name'),
                  TextField(
                    controller: _companyName,
                    decoration: _decoration('Enter company name'),
                    style: KraftsTextStyles.phoneInput(),
                  ),
                  const SizedBox(height: KraftsSpacing.md),
                  _optionalLabel('Company Email'),
                  TextField(
                    controller: _companyEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoration('company@email.com'),
                    style: KraftsTextStyles.phoneInput(),
                  ),
                  const SizedBox(height: KraftsSpacing.md),
                  _optionalLabel('Company Phone'),
                  TextField(
                    controller: _companyPhone,
                    keyboardType: TextInputType.phone,
                    decoration: _decoration('+1 (555) 000-0000'),
                    style: KraftsTextStyles.phoneInput(),
                  ),
                  const SizedBox(height: KraftsSpacing.md),
                  _optionalLabel('Company Logo'),
                  const SizedBox(height: KraftsSpacing.sm),
                  Material(
                    color: KraftsColors.white,
                    child: InkWell(
                      onTap: () => _onPickPlaceholder('Company logo'),
                      borderRadius: BorderRadius.circular(KraftsRadius.field),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 36),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(KraftsRadius.field),
                          border: Border.all(
                            color: KraftsColors.inputBorder,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 40,
                              color: KraftsColors.roleMuted,
                            ),
                            const SizedBox(height: KraftsSpacing.sm),
                            Text(
                              'Tap to upload logo',
                              style: KraftsTextStyles.subtitle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: KraftsSpacing.md),
                  _requiredLabel('State'),
                  _dropdownField(
                    hint: 'Select State',
                    value: _state,
                    items: _states,
                    onChanged: (v) => setState(() => _state = v),
                  ),
                  const SizedBox(height: KraftsSpacing.md),
                  _requiredLabel('City/Town'),
                  TextField(
                    controller: _city,
                    decoration: _decoration('Enter city or town'),
                    style: KraftsTextStyles.phoneInput(),
                  ),
                ],
                const SizedBox(height: KraftsSpacing.xl),
                _sectionHeader('Media & Links'),
                _optionalLabel('Gallery Images'),
                const SizedBox(height: KraftsSpacing.sm),
                Row(
                  children: List.generate(3, (i) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: i < 2 ? KraftsSpacing.sm : 0,
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Material(
                            color: KraftsColors.white,
                            child: InkWell(
                              onTap: () =>
                                  _onPickPlaceholder('Gallery image ${i + 1}'),
                              borderRadius:
                                  BorderRadius.circular(12),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                    color: KraftsColors.inputBorder,
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 32,
                                    color: KraftsColors.roleMuted,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _optionalLabel('Website'),
                TextField(
                  controller: _website,
                  keyboardType: TextInputType.url,
                  decoration: _decoration('https://yourwebsite.com'),
                  style: KraftsTextStyles.phoneInput(),
                ),
                const SizedBox(height: KraftsSpacing.md),
                _optionalLabel('Social Media Links'),
                const SizedBox(height: KraftsSpacing.sm),
                _socialField(
                  icon: Icons.facebook_rounded,
                  iconColor: KraftsColors.facebookBlue,
                  controller: _facebook,
                  hint: 'Facebook profile URL',
                ),
                const SizedBox(height: KraftsSpacing.sm),
                _socialField(
                  icon: Icons.tag_rounded,
                  iconColor: KraftsColors.twitterBlue,
                  controller: _twitter,
                  hint: 'Twitter profile URL',
                ),
                const SizedBox(height: KraftsSpacing.sm),
                _socialField(
                  icon: Icons.business_center_outlined,
                  iconColor: KraftsColors.linkedInBlue,
                  controller: _linkedin,
                  hint: 'LinkedIn profile URL',
                ),
                const SizedBox(height: KraftsSpacing.md),
                _optionalLabel('Custom Links'),
                const SizedBox(height: KraftsSpacing.sm),
                ...List.generate(_customLinks.length, (index) {
                  final row = _customLinks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: KraftsSpacing.sm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: row.title,
                            decoration: _decoration('Link title'),
                            style: KraftsTextStyles.phoneInput(),
                          ),
                        ),
                        const SizedBox(width: KraftsSpacing.sm),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: row.url,
                            keyboardType: TextInputType.url,
                            decoration: _decoration('https://example.com'),
                            style: KraftsTextStyles.phoneInput(),
                          ),
                        ),
                        IconButton(
                          onPressed: _customLinks.length <= 1
                              ? null
                              : () {
                                  setState(() {
                                    final removed = _customLinks.removeAt(index);
                                    removed.dispose();
                                  });
                                },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: KraftsColors.requiredStar,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() => _customLinks.add(_CustomLinkRow()));
                    },
                    icon: const Icon(Icons.add, color: KraftsColors.linkAction),
                    label: Text(
                      'Add Another Link',
                      style: KraftsTextStyles.fieldLabel().copyWith(
                        color: KraftsColors.linkAction,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: KraftsSpacing.xl),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                KraftsSpacing.lg,
                KraftsSpacing.sm,
                KraftsSpacing.lg,
                KraftsSpacing.lg,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Draft saved (local)')),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: KraftsColors.draftButtonBg,
                        foregroundColor: KraftsColors.draftButtonText,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(KraftsRadius.button),
                        ),
                      ),
                      child: Text('Save Draft', style: KraftsTextStyles.draftButton()),
                    ),
                  ),
                  const SizedBox(width: KraftsSpacing.md),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (context) => AadhaarVerificationScreen(
                              isRecruiter: widget.isRecruiter,
                            ),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: KraftsColors.purpleVerify,
                        foregroundColor: KraftsColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(KraftsRadius.button),
                        ),
                      ),
                      child: Text('Continue', style: KraftsTextStyles.primaryButton()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialField({
    required IconData icon,
    required Color iconColor,
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.url,
      style: KraftsTextStyles.phoneInput(),
      decoration: _decoration(hint).copyWith(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 48),
      ),
    );
  }
}
