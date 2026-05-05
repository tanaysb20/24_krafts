import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'krafts_design.dart';
import 'profile_screen.dart';

enum JobSection { relevant, allJobs, applied, posted }

class JobUpdatesScreen extends StatefulWidget {
  const JobUpdatesScreen({super.key, this.embedded = false, this.onBack});

  final bool embedded;
  final VoidCallback? onBack;

  @override
  State<JobUpdatesScreen> createState() => _JobUpdatesScreenState();
}

class _JobUpdatesScreenState extends State<JobUpdatesScreen> {
  static const Color _pageBg = Color(0xFFF6F2FF);
  static const Color _pillGreen = KraftsColors.dashboardPurple;
  static const Color _mutedText = Color(0xFF3A3A3A);

  JobSection _selectedSection = JobSection.relevant;

  final List<JobItem> _jobs = const [
    JobItem(
      title: 'Lead Actor for Feature Film',
      subtitle:
          'looking for a senior actor for father character for up coming web series in multi lingual , An amazon Prime funding project....',
      imageUrl:
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?auto=format&fit=crop&w=400&q=60',
      favorite: true,
    ),
    JobItem(
      title: 'Lead Actor for Feature Film',
      subtitle:
          'looking for a senior actor for father character for up coming web series in multi lingual , An amazon Prime funding project....',
      imageUrl:
          'https://images.unsplash.com/photo-1478720568477-152d9b164e26?auto=format&fit=crop&w=400&q=60',
      favorite: true,
    ),
    JobItem(
      title: 'Lead Actor for Feature Film',
      subtitle:
          'looking for a senior actor for father character for up coming web series in multi lingual , An amazon Prime funding project....',
      imageUrl:
          'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?auto=format&fit=crop&w=400&q=60',
    ),
  ];

  final List<JobItem> _appliedJobs = const [
    JobItem(
      title: 'Character Artist for Thriller',
      subtitle:
          'Application submitted for a supporting role in an urban thriller project. Waiting for recruiter review.',
      imageUrl:
          'https://images.unsplash.com/photo-1517602302552-471fe67acf66?auto=format&fit=crop&w=400&q=60',
      favorite: true,
    ),
    JobItem(
      title: 'Voice Artist for Web Series',
      subtitle:
          'Applied to dubbing role for a multi-lingual OTT series with remote recording options.',
      imageUrl:
          'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=400&q=60',
    ),
  ];

  final List<JobItem> _postedJobs = const [
    JobItem(
      title: 'Lead Actor for Feature Film',
      subtitle:
          'Your posted role for lead actor is live and receiving responses from shortlisted artists.',
      imageUrl:
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?auto=format&fit=crop&w=400&q=60',
      favorite: true,
    ),
    JobItem(
      title: 'Action Choreographer Requirement',
      subtitle:
          'Casting call posted for action team coordination and choreography support.',
      imageUrl:
          'https://images.unsplash.com/photo-1478720568477-152d9b164e26?auto=format&fit=crop&w=400&q=60',
    ),
  ];

  List<JobItem> get _visibleJobs {
    switch (_selectedSection) {
      case JobSection.relevant:
      case JobSection.allJobs:
        return _jobs;
      case JobSection.applied:
        return _appliedJobs;
      case JobSection.posted:
        return _postedJobs;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _JobTopBar(
          title: "JOB Update's",
          showBack: !widget.embedded,
          onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
          onProfileTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
            );
          },
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _segmentPill(
                      label: 'Relevent',
                      selected: _selectedSection == JobSection.relevant,
                      onTap: () =>
                          setState(() => _selectedSection = JobSection.relevant),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _segmentPill(
                      label: 'All Jobs',
                      selected: _selectedSection == JobSection.allJobs,
                      onTap: () =>
                          setState(() => _selectedSection = JobSection.allJobs),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _segmentPill(
                      label: 'Applied',
                      selected: _selectedSection == JobSection.applied,
                      onTap: () =>
                          setState(() => _selectedSection = JobSection.applied),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _segmentPill(
                      label: 'Posted',
                      selected: _selectedSection == JobSection.posted,
                      onTap: () =>
                          setState(() => _selectedSection = JobSection.posted),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Text(
                      '${_visibleJobs.length} Job Opportunity',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _mutedText,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_rounded,
                      size: 18,
                      color: Color(0xFFDA741F),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Fav List',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ..._visibleJobs.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _JobListCard(
                    job: job,
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (_) => JobDetailsScreen(job: job),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (widget.embedded) {
      return ColoredBox(color: _pageBg, child: content);
    }

    return Scaffold(backgroundColor: _pageBg, body: content);
  }

  Widget _segmentPill({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: selected ? _pillGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : _mutedText,
          ),
        ),
      ),
    );
  }
}

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key, required this.job});

  static const Color _pageBg = Color(0xFFF6F2FF);
  static const Color _bodyText = Color(0xFF373737);
  static const Color _locationColor = KraftsColors.dashboardPurple;
  static const Color _applyLeft = KraftsColors.purpleDeep;
  static const Color _applyRight = KraftsColors.purpleLight;

  final JobItem job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      body: Column(
        children: [
          _JobTopBar(
            title: 'JOB Details',
            showBack: true,
            onBack: () => Navigator.of(context).maybePop(),
            onProfileTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 180,
                    child: Image.network(job.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        job.title,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF232323),
                          height: 1.1,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: Color(0xFFD38A6B),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _bodyText,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  job.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _bodyText,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Male',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _locationColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Age 45+',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _bodyText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Location',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _locationColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Hyderabad',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _bodyText,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  'Date Posted',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _locationColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24/Feb/2025',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _bodyText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '28/Feb/2025',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _bodyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: KraftsColors.dashboardPurple.withValues(
                          alpha: 0.14,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.event_note_rounded,
                        size: 18,
                        color: KraftsColors.dashboardPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [_applyLeft, _applyRight],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => _showAppliedDialog(context),
                        child: Center(
                          child: Text(
                            'Apply',
                            style: GoogleFonts.inter(
                              fontSize: 20,
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
          ),
        ],
      ),
    );
  }

  Future<void> _showAppliedDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Job Applied Successfully',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5A5A5A),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 94,
                  height: 94,
                  decoration: const BoxDecoration(
                    color: KraftsColors.dashboardPurple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 56),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: 148,
                  height: 34,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [
                          KraftsColors.purpleDeep,
                          KraftsColors.purpleLight,
                        ],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Navigator.of(context).pop(),
                        child: Center(
                          child: Text(
                            'Done',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _JobTopBar extends StatelessWidget {
  const _JobTopBar({
    required this.title,
    required this.showBack,
    required this.onBack,
    this.onProfileTap,
  });

  final String title;
  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 52,
        color: KraftsColors.dashboardPurple,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            if (showBack)
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
                iconSize: 18,
                splashRadius: 18,
                tooltip: 'Back',
              ),
            _TopIconLabel(
              icon: Icons.person,
              label: 'Profile',
              onTap: onProfileTap,
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const _TopIconLabel(
              icon: Icons.chat_bubble_rounded,
              label: "Chat's",
            ),
          ],
        ),
      ),
    );
  }
}

class _TopIconLabel extends StatelessWidget {
  const _TopIconLabel({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobListCard extends StatelessWidget {
  const _JobListCard({required this.job, required this.onTap});

  final JobItem job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFE5DAF8)),
          ),
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: SizedBox(
                  width: 60,
                  height: 45,
                  child: Image.network(job.imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            job.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF292929),
                              height: 1.1,
                            ),
                          ),
                        ),
                        Icon(
                          job.favorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: KraftsColors.dashboardPurple,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job.subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4E4E4E),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '...Read More',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF313131),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobItem {
  const JobItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.favorite = false,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final bool favorite;
}
