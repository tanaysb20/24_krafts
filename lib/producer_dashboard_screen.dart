import 'package:_24_krafts/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_project_screen.dart';
import 'job_updates_screen.dart';
import 'krafts_design.dart';
import 'members_screen.dart';
import 'project_details_screen.dart';
import 'responsive.dart';

/// Film Producer (recruiter) home dashboard.
///
/// Figma: https://www.figma.com/design/RoBxclHMsmzXWhQAHmE69v/24-Crafts?node-id=15-892
class ProducerDashboardScreen extends StatefulWidget {
  const ProducerDashboardScreen({super.key, this.isRecruiter = true});

  final bool isRecruiter;

  @override
  State<ProducerDashboardScreen> createState() =>
      _ProducerDashboardScreenState();
}

class _ProducerDashboardScreenState extends State<ProducerDashboardScreen> {
  final _carouselController = PageController();
  int _carouselPage = 0;
  int _bottomIndex = 0;

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return Scaffold(
      backgroundColor: KraftsColors.white,
      body: _bottomIndex == 3
          ? JobUpdatesScreen(
              embedded: true,
              onBack: () => setState(() => _bottomIndex = 0),
            )
          : _bottomIndex == 1
          ? MembersScreen(
              embedded: true,
              onBack: () => setState(() => _bottomIndex = 0),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _DashboardHeader(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      KraftsSpacing.lg * s,
                      KraftsSpacing.md * s,
                      KraftsSpacing.lg * s,
                      KraftsSpacing.lg * s,
                    ),
                    children: [
                      _PromoCarousel(
                        controller: _carouselController,
                        page: _carouselPage,
                        onPageChanged: (i) => setState(() => _carouselPage = i),
                      ),
                      SizedBox(height: KraftsSpacing.lg * s),
                      const _SummaryRow(),
                      SizedBox(height: KraftsSpacing.lg * s),
                      const _FavoritesSection(),
                      SizedBox(height: KraftsSpacing.lg * s),
                      _MovieProjectsSection(
                        onOpenProject:
                            ({
                              required title,
                              required meta,
                              required statusLabel,
                              required statusColor,
                              required gradient,
                            }) {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) => ProjectDetailsScreen(
                                    title: title,
                                    meta: meta,
                                    statusLabel: statusLabel,
                                    statusColor: statusColor,
                                    gradient: gradient,
                                    isRecruiter: widget.isRecruiter,
                                  ),
                                ),
                              );
                            },
                      ),
                      SizedBox(
                        height: MediaQuery.paddingOf(context).bottom + 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: _ProducerBottomNav(
        currentIndex: _bottomIndex,
        onTap: (i) {
          setState(() => _bottomIndex = i);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: (_bottomIndex != 0 || !widget.isRecruiter)
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => const CreateProjectScreen(),
                  ),
                );
              },
              backgroundColor: KraftsColors.dashboardPurple,
              foregroundColor: KraftsColors.white,
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: Text(
                'Create Project',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: KraftsColors.white,
                ),
              ),
            ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: KraftsColors.dashboardPurple),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            KraftsSpacing.lg,
            KraftsSpacing.sm,
            KraftsSpacing.lg,
            KraftsSpacing.md,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  child: Text(
                    'SJ',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: KraftsColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: KraftsSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sarah Johnson',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: KraftsColors.white,
                        ),
                      ),
                      Text(
                        'Film Producer',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        foregroundColor: KraftsColors.white,
                      ),
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: KraftsColors.requiredStar,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '3',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: KraftsColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PromoCarousel extends StatelessWidget {
  const _PromoCarousel({
    required this.controller,
    required this.page,
    required this.onPageChanged,
  });

  final PageController controller;
  final int page;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final carouselHeight = context.rh(132).clamp(116.0, 170.0);
    return Column(
      children: [
        SizedBox(
          height: carouselHeight,
          child: PageView(
            controller: controller,
            onPageChanged: onPageChanged,
            children: const [
              _BannerSlide(
                title: 'Streaming Services',
                chips: 'Apple TV+ · Netflix · Peacock · Prime · Disney+ · Hulu',
              ),
              _BannerSlide(
                title: 'CTV Devices',
                chips: 'PlayStation · Samsung TV · Xbox · Fire TV · Roku · LG',
              ),
              _BannerSlide(
                title: 'Reach every screen',
                chips: 'Distribute your productions across platforms',
              ),
            ],
          ),
        ),
        const SizedBox(height: KraftsSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final active = i == page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active
                    ? KraftsColors.dashboardPurple
                    : KraftsColors.inputBorder,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _BannerSlide extends StatelessWidget {
  const _BannerSlide({required this.title, required this.chips});

  final String title;
  final String chips;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.all(KraftsSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [KraftsColors.bannerDark, Color(0xFF312E81)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: KraftsColors.white,
            ),
          ),
          const SizedBox(height: KraftsSpacing.xs),
          Text(
            chips,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompactWidth;
    return IntrinsicHeight(
      child: Flex(
        direction: compact ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _SummaryCard(
              icon: Icons.calendar_today_rounded,
              iconColor: KraftsColors.linkAction,
              title: "Today's Schedule",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('10:00 AM — Script Review', style: _summaryLineStyle()),
                  const SizedBox(height: 6),
                  Text('2:00 PM — Location Scout', style: _summaryLineStyle()),
                ],
              ),
            ),
          ),
          SizedBox(
            width: compact ? 0 : KraftsSpacing.md,
            height: compact ? KraftsSpacing.md : 0,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return JobUpdatesScreen();
                    },
                  ),
                );
              },
              child: _SummaryCard(
                icon: Icons.work_outline_rounded,
                iconColor: KraftsColors.statusGreen,
                title: 'Jobs Applied',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '12',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: KraftsColors.headline,
                      ),
                    ),
                    Text(
                      'Active Applications',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: KraftsColors.subtitle,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '+3 this week',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: KraftsColors.statusGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static TextStyle _summaryLineStyle() {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: KraftsColors.label,
      height: 1.3,
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KraftsSpacing.md),
      decoration: BoxDecoration(
        color: KraftsColors.white,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: KraftsColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: KraftsSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: KraftsColors.headline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: KraftsSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _FavoritesSection extends StatelessWidget {
  const _FavoritesSection();

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompactWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Favorites',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: KraftsColors.headline,
              ),
            ),
            Icon(
              Icons.favorite_rounded,
              color: KraftsColors.requiredStar.withValues(alpha: 0.9),
              size: 22,
            ),
          ],
        ),
        const SizedBox(height: KraftsSpacing.md),
        Wrap(
          spacing: KraftsSpacing.sm,
          runSpacing: KraftsSpacing.sm,
          children: [
            SizedBox(
              width: compact
                  ? (MediaQuery.sizeOf(context).width - (KraftsSpacing.lg * 2))
                  : (MediaQuery.sizeOf(context).width -
                                (KraftsSpacing.lg * 2)) /
                            3 -
                        KraftsSpacing.sm,
              child: const _FavoriteTile(
                color: KraftsColors.favoriteBlue,
                icon: Icons.movie_filter_rounded,
                label: 'Projects',
                value: '8',
              ),
            ),
            SizedBox(
              width: compact
                  ? (MediaQuery.sizeOf(context).width - (KraftsSpacing.lg * 2))
                  : (MediaQuery.sizeOf(context).width -
                                (KraftsSpacing.lg * 2)) /
                            3 -
                        KraftsSpacing.sm,
              child: const _FavoriteTile(
                color: KraftsColors.favoritePurple,
                icon: Icons.groups_rounded,
                label: 'Teams',
                value: '5',
              ),
            ),
            SizedBox(
              width: compact
                  ? (MediaQuery.sizeOf(context).width - (KraftsSpacing.lg * 2))
                  : (MediaQuery.sizeOf(context).width -
                                (KraftsSpacing.lg * 2)) /
                            3 -
                        KraftsSpacing.sm,
              child: const _FavoriteTile(
                color: KraftsColors.favoriteOrange,
                icon: Icons.bookmark_rounded,
                label: 'Saved',
                value: '15',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.85,
      child: Container(
        padding: const EdgeInsets.all(KraftsSpacing.sm),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: KraftsColors.headline.withValues(alpha: 0.75),
            ),
            const SizedBox(height: KraftsSpacing.sm),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: KraftsColors.headline,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: KraftsColors.headline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieProjectsSection extends StatelessWidget {
  const _MovieProjectsSection({required this.onOpenProject});

  final void Function({
    required String title,
    required String meta,
    required String statusLabel,
    required Color statusColor,
    required List<Color> gradient,
  })
  onOpenProject;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Movie Projects',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: KraftsColors.headline,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: KraftsColors.linkAction,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: KraftsSpacing.md),
        _MovieCard(
          title: 'Spirit',
          meta: 'Drama • 2024',
          statusLabel: 'In Production',
          statusIcon: Icons.play_circle_fill_rounded,
          statusColor: KraftsColors.statusGreen,
          heartFilled: false,
          gradient: const [Color(0xFF7C3AED), Color(0xFFA78BFA)],
          onTap: () => onOpenProject(
            title: 'Sprint Movie',
            meta: 'Drama • 2024',
            statusLabel: 'In Production',
            statusColor: KraftsColors.statusGreen,
            gradient: const [Color(0xFF7C3AED), Color(0xFFA78BFA)],
          ),
        ),
        const SizedBox(height: KraftsSpacing.md),
        _MovieCard(
          title: 'Kooli',
          meta: 'Thriller • 2024',
          statusLabel: 'Pre-Production',
          statusIcon: Icons.schedule_rounded,
          statusColor: KraftsColors.statusBlue,
          heartFilled: true,
          heartColor: KraftsColors.requiredStar,
          gradient: const [Color(0xFF475569), Color(0xFF64748B)],
          onTap: () => onOpenProject(
            title: 'Kooli',
            meta: 'Thriller • 2024',
            statusLabel: 'Pre-Production',
            statusColor: KraftsColors.statusBlue,
            gradient: const [Color(0xFF475569), Color(0xFF64748B)],
          ),
        ),
        const SizedBox(height: KraftsSpacing.md),
        _MovieCard(
          title: 'Viswambara',
          meta: 'Epic • 2025',
          statusLabel: 'Development',
          statusIcon: Icons.edit_rounded,
          statusColor: KraftsColors.statusAmber,
          heartFilled: false,
          gradient: const [Color(0xFFCA8A04), Color(0xFFFDE047)],
          onTap: () => onOpenProject(
            title: 'Viswambara',
            meta: 'Epic • 2025',
            statusLabel: 'Development',
            statusColor: KraftsColors.statusAmber,
            gradient: const [Color(0xFFCA8A04), Color(0xFFFDE047)],
          ),
        ),
      ],
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    required this.title,
    required this.meta,
    required this.statusLabel,
    required this.statusIcon,
    required this.statusColor,
    required this.gradient,
    required this.onTap,
    this.heartFilled = false,
    this.heartColor,
  });

  final String title;
  final String meta;
  final String statusLabel;
  final IconData statusIcon;
  final Color statusColor;
  final List<Color> gradient;
  final VoidCallback onTap;
  final bool heartFilled;
  final Color? heartColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(KraftsRadius.field),
        child: Container(
          decoration: BoxDecoration(
            color: KraftsColors.white,
            borderRadius: BorderRadius.circular(KraftsRadius.field),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: KraftsColors.inputBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradient,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(KraftsSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: KraftsColors.headline,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      meta,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: KraftsColors.subtitle,
                      ),
                    ),
                    const SizedBox(height: KraftsSpacing.sm),
                    Row(
                      children: [
                        Icon(statusIcon, size: 18, color: statusColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            statusLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: KraftsColors.subtitle,
                            ),
                          ),
                        ),
                        Icon(
                          heartFilled
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 22,
                          color: heartColor ?? KraftsColors.roleMuted,
                        ),
                      ],
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

class _ProducerBottomNav extends StatelessWidget {
  const _ProducerBottomNav({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_rounded, 'Home'),
      (Icons.groups_rounded, 'Members'),
      (Icons.calendar_month_rounded, 'Schedule'),
      (Icons.work_outline_rounded, 'Jobs'),
    ];
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: KraftsColors.dashboardPurple,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final sel = i == currentIndex;
              final icon = items[i].$1;
              final label = items[i].$2;
              return InkWell(
                onTap: () => onTap(i),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: sel
                            ? KraftsColors.white
                            : Colors.white.withValues(alpha: 0.65),
                        size: 26,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                          color: sel
                              ? KraftsColors.white
                              : Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
