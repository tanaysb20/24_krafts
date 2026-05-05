import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'krafts_design.dart';

class CreateJobFlowScreen extends StatefulWidget {
  const CreateJobFlowScreen({super.key});

  @override
  State<CreateJobFlowScreen> createState() => _CreateJobFlowScreenState();
}

class _CreateJobFlowScreenState extends State<CreateJobFlowScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _mapController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  String _gender = 'Female';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _mapController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        color: KraftsColors.subtitle,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: KraftsSpacing.md,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: KraftsColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: KraftsColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: KraftsColors.dashboardPurple, width: 1.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FF),
      appBar: AppBar(
        backgroundColor: KraftsColors.dashboardPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create Job',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        children: [
          TextField(
            controller: _titleController,
            decoration: _decoration('Job Title'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _descriptionController,
            maxLines: 5,
            decoration: _decoration('Job Description'),
          ),
          const SizedBox(height: 16),
          Text(
            'Gender',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: KraftsColors.label,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _GenderChip(
                label: 'Female',
                selected: _gender == 'Female',
                onTap: () => setState(() => _gender = 'Female'),
              ),
              const SizedBox(width: 10),
              _GenderChip(
                label: 'Male',
                selected: _gender == 'Male',
                onTap: () => setState(() => _gender = 'Male'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ageController,
                  decoration: _decoration('Age'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: _decoration('Location (City)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _mapController,
            decoration: _decoration('Map URL (location)'),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _startDateController,
                  decoration: _decoration('Start Date'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _endDateController,
                  decoration: _decoration('End Date'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [KraftsColors.purpleDeep, KraftsColors.dashboardPurple],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: KraftsColors.dashboardPurple.withValues(alpha: 0.28),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const _JobCreatedSuccessScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text(
                      'Create Job',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected
            ? KraftsColors.dashboardPurple.withValues(alpha: 0.14)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? KraftsColors.dashboardPurple
                    : KraftsColors.inputBorder,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? KraftsColors.dashboardPurple
                      : KraftsColors.label,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _JobCreatedSuccessScreen extends StatelessWidget {
  const _JobCreatedSuccessScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FF),
      appBar: AppBar(
        backgroundColor: KraftsColors.dashboardPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Project Created',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Container(
          width: 320,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Job Created Successfully',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: KraftsColors.statusGreen,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: KraftsColors.statusGreen.withValues(alpha: 0.14),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: KraftsColors.statusGreen,
                  size: 72,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: 170,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: KraftsColors.statusGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Done',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
