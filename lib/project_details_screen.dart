import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_job_flow_screen.dart';
import 'krafts_design.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({
    super.key,
    required this.title,
    required this.meta,
    required this.statusLabel,
    required this.statusColor,
    required this.gradient,
    this.isRecruiter = false,
  });

  final String title;
  final String meta;
  final String statusLabel;
  final Color statusColor;
  final List<Color> gradient;
  final bool isRecruiter;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  static const Color _pageAccent = KraftsColors.dashboardPurple;
  static const Color _surfaceBg = Color(0xFFF6F2FF);
  bool _showFullDescription = false;

  static const String _description =
      'As reported earlier, Prabhas will play the role of a cop in Spirit. '
      'Director Sandeep Reddy Vanga had mentioned previously that the film '
      'will be made on a massive budget of Rs 300 crore.\n\n'
      "Prabhas is also set to star in 'Spirit', a cop drama directed by "
      "'Animal' fame Sandeep Reddy Vanga. As per a report by 123Telugu, "
      "during the promotions of another project, filmmaker Bhushan Kumar "
      "revealed that the casting process for 'Spirit' would begin soon, "
      'with plans to start filming by the end of December 2024.\n\n'
      'Korean Actor Ma Dong-Seok As Villain In Spirit Movie\n\n'
      'The actor charged Rs 80 crores for Kalki 2898 AD considering the '
      'lavish budget and the span. He has been charging Rs 150 crores for '
      'Raja Saab and Spirit. After the super success of Kalki 2898 AD, '
      'Prabhas hiked his fee and he is demanding Rs 200 crores for all his '
      'new projects.';

  void _openCreateJobFlow() {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const CreateJobFlowScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surfaceBg,
      body: Column(
        children: [
          _TopBar(accent: _pageAccent),
          Expanded(
            child: Stack(
              children: [
                const _HeroPoster(),
                Positioned.fill(
                  top: 182,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: _surfaceBg,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.title == 'Spirit'
                                      ? 'Sprint Movie'
                                      : widget.title,
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: KraftsColors.headline,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                children: [
                                  Text(
                                    'Shedule',
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: KraftsColors.dashboardPurple,
                                      height: 1.0,
                                    ),
                                  ),
                                  Icon(
                                    Icons.event_note_rounded,
                                    color: _pageAccent,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _description,
                            maxLines: _showFullDescription ? null : 4,
                            overflow: _showFullDescription
                                ? null
                                : TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: KraftsColors.label,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showFullDescription = !_showFullDescription;
                              });
                            },
                            child: Text(
                              _showFullDescription
                                  ? 'Read Less'
                                  : '...Read More',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: KraftsColors.dashboardPurple,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _PeopleSection(
                            title: 'Lead Actors',
                            accent: _pageAccent,
                            showAddMoreWhenEmpty: widget.isRecruiter,
                            onAddMoreTap: _openCreateJobFlow,
                            entries: const [
                              _PersonTileData(
                                name: 'Prabhas',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=160&q=60',
                              ),
                              _PersonTileData(
                                name: 'Kiara Advani',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=160&q=60',
                              ),
                              _PersonTileData(
                                name: 'Ma Dong\nSeok',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=160&q=60',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _PeopleSection(
                            title: 'Director / Producer',
                            accent: _pageAccent,
                            showAddMoreWhenEmpty: widget.isRecruiter,
                            onAddMoreTap: _openCreateJobFlow,
                            entries: const [
                              _PersonTileData(
                                name: 'Sandeep\nReddy\nVanga',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1542204625-de293a2f9443?auto=format&fit=crop&w=160&q=60',
                              ),
                              _PersonTileData(
                                name: 'Bhushan\nKumar',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1521119989659-a83eee488004?auto=format&fit=crop&w=160&q=60',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _PeopleSection(
                            title: 'Cast',
                            accent: _pageAccent,
                            showAddMoreWhenEmpty: widget.isRecruiter,
                            onAddMoreTap: _openCreateJobFlow,
                            entries: const [],
                          ),
                          const SizedBox(height: 12),
                          _PeopleSection(
                            title: 'Music',
                            accent: _pageAccent,
                            showAddMoreWhenEmpty: widget.isRecruiter,
                            onAddMoreTap: _openCreateJobFlow,
                            entries: const [],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNav(accent: _pageAccent),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 54,
        color: accent,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: Colors.white,
              iconSize: 18,
              splashRadius: 20,
              tooltip: 'Back',
            ),
            const _HeaderAction(icon: Icons.person, label: 'Profile'),
            Expanded(
              child: Center(
                child: Text(
                  'Project Details',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const _HeaderAction(icon: Icons.chat_bubble, label: "Chat's"),
          ],
        ),
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 9,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPoster extends StatelessWidget {
  const _HeroPoster();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?auto=format&fit=crop&w=1200&q=80',
          ),
        ),
      ),
    );
  }
}

class _PeopleSection extends StatelessWidget {
  const _PeopleSection({
    required this.title,
    required this.entries,
    required this.accent,
    this.showAddMoreWhenEmpty = true,
    this.onAddMoreTap,
  });

  final String title;
  final List<_PersonTileData> entries;
  final Color accent;
  final bool showAddMoreWhenEmpty;
  final VoidCallback? onAddMoreTap;

  @override
  Widget build(BuildContext context) {
    final hasSelectedArtists = entries.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: KraftsColors.headline,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 96),
          padding: const EdgeInsets.fromLTRB(14, 8, 10, 8),
          decoration: BoxDecoration(
            color: KraftsColors.favoritePurple.withValues(alpha: 0.38),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: KraftsColors.purpleLight.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: KraftsColors.purpleDeep.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: hasSelectedArtists
                    ? Row(
                        children: entries
                            .map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: _PersonTile(entry: entry),
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox(height: 78),
              ),
              if (showAddMoreWhenEmpty) ...[
                const SizedBox(width: 6),
                _AddMorePill(onTap: onAddMoreTap),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({required this.entry});

  final _PersonTileData entry;

  @override
  Widget build(BuildContext context) {
    final displayName = entry.name.replaceAll('\n', ' ');

    return SizedBox(
      width: 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            foregroundImage: NetworkImage(entry.imageUrl),
          ),
          const SizedBox(height: 5),
          Text(
            displayName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: KraftsColors.label,
              fontSize: 10,
              height: 1.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonTileData {
  const _PersonTileData({required this.name, required this.imageUrl});

  final String name;
  final String imageUrl;
}

class _AddMorePill extends StatelessWidget {
  const _AddMorePill({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: KraftsColors.dashboardPurple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x44000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 2),
              Text(
                'Add More',
                maxLines: 1,
                style: GoogleFonts.inter(
                  color: KraftsColors.dashboardPurple,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    Widget item(IconData icon, String label, {bool selected = false}) {
      final color = selected
          ? Colors.white
          : Colors.white.withValues(alpha: 0.8);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      );
    }

    return Container(
      color: accent,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              item(Icons.home_rounded, 'Home'),
              item(Icons.groups_rounded, 'Members'),
              item(Icons.edit_calendar_rounded, 'Schedules'),
              item(Icons.work_rounded, "Project's", selected: true),
            ],
          ),
        ),
      ),
    );
  }
}
