import 'package:_24_krafts/producer_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'krafts_design.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        color: KraftsColors.label.withValues(alpha: 0.7),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: Colors.white,
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
          color: KraftsColors.dashboardPurple,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: KraftsColors.dashboardPurple,
        foregroundColor: KraftsColors.white,
        centerTitle: true,
        title: Text(
          'Create a Project',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 19),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            KraftsSpacing.lg,
            KraftsSpacing.lg,
            KraftsSpacing.lg,
            KraftsSpacing.lg,
          ),
          child: Container(
            padding: const EdgeInsets.all(KraftsSpacing.lg),
            decoration: BoxDecoration(
              color: KraftsColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: KraftsColors.dashboardPurple.withValues(alpha: 0.25),
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add Project Cover Photo - hook picker'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(KraftsRadius.field),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: KraftsColors.favoriteOrange.withValues(
                        alpha: 0.45,
                      ),
                      borderRadius: BorderRadius.circular(KraftsRadius.field),
                      border: Border.all(color: KraftsColors.inputBorder),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 42,
                          color: KraftsColors.dashboardPurple,
                        ),
                        const SizedBox(height: KraftsSpacing.sm),
                        Text(
                          'Add Project Cover Photo',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: KraftsColors.dashboardPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: KraftsSpacing.lg),
                TextField(
                  controller: _titleController,
                  style: KraftsTextStyles.phoneInput(),
                  decoration: _fieldDecoration('Project Title'),
                ),
                const SizedBox(height: KraftsSpacing.md),
                TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  style: KraftsTextStyles.phoneInput(),
                  decoration: _fieldDecoration('Project Description'),
                ),
                const SizedBox(height: KraftsSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _startDateController,
                        style: KraftsTextStyles.phoneInput(),
                        decoration: _fieldDecoration('Start Date'),
                      ),
                    ),
                    const SizedBox(width: KraftsSpacing.md),
                    Expanded(
                      child: TextField(
                        controller: _endDateController,
                        style: KraftsTextStyles.phoneInput(),
                        decoration: _fieldDecoration('End Date'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: KraftsSpacing.xl),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [KraftsColors.statusGreen, Color(0xFF4D7C0F)],
                    ),
                    borderRadius: BorderRadius.circular(KraftsRadius.button),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (_) => const ProjectCreatedScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(KraftsRadius.button),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: KraftsSpacing.md,
                        ),
                        child: Center(
                          child: Text(
                            'Create a Project',
                            style: KraftsTextStyles.primaryButton(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectCreatedScreen extends StatelessWidget {
  const ProjectCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6E5EA),
      appBar: AppBar(
        backgroundColor: KraftsColors.dashboardPurple,
        foregroundColor: KraftsColors.white,
        centerTitle: true,
        title: Text(
          'Project Created',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 19),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(KraftsSpacing.lg),
          child: Container(
            padding: const EdgeInsets.all(KraftsSpacing.xl),
            decoration: BoxDecoration(
              color: KraftsColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Project Created Successfully',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: KraftsColors.label,
                  ),
                ),
                const SizedBox(height: KraftsSpacing.lg),
                Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4D7C0F),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                const SizedBox(height: KraftsSpacing.xl),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [KraftsColors.statusGreen, Color(0xFF4D7C0F)],
                    ),
                    borderRadius: BorderRadius.circular(KraftsRadius.button),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(
                            builder: (_) => const ProducerDashboardScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      borderRadius: BorderRadius.circular(KraftsRadius.button),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: KraftsSpacing.md,
                        ),
                        child: Text(
                          'Done',
                          style: KraftsTextStyles.primaryButton(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
