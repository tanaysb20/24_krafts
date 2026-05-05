import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'krafts_design.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _pageBg = Color(0xFFF6F2FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      body: Column(
        children: [
          _ProfileTopBar(onBack: () => Navigator.of(context).maybePop()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=60',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Pavan Vijay Kumar M',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: KraftsColors.headline,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _infoText(
                    'pa1iotne@gmail.com',
                    icon: Icons.mail_outline_rounded,
                  ),
                  _infoText('8297808410'),
                  _infoText('8074794622'),
                  _infoText('MAA9483XXXXX'),
                  _infoText('Male'),
                  _infoText('Director , Actor , Dancer'),
                  _infoText('Andhra Pradesh', icon: Icons.location_on_rounded),
                  _infoText('Vijayawada', icon: Icons.location_on_rounded),
                  const SizedBox(height: 12),
                  _actionButton(label: 'Message', onTap: () {}, width: 230),
                  const SizedBox(height: 16),
                  // Row(
                  //   children: const [
                  //     Expanded(child: _GalleryBox()),
                  //     SizedBox(width: 10),
                  //     Expanded(child: _GalleryBox()),
                  //     SizedBox(width: 10),
                  //     Expanded(child: _GalleryBox()),
                  //   ],
                  // ),
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: KraftsColors.favoritePurple.withValues(
                        alpha: 0.45,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _SocialChip(icon: Icons.facebook_rounded),
                        _SocialChip(icon: Icons.camera_alt_rounded),
                        _SocialChip(icon: Icons.language_rounded),
                        _SocialChip(icon: Icons.play_circle_fill_rounded),
                        _SocialChip(icon: Icons.close_rounded),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  _actionButton(
                    label: 'Become a Recruiter',
                    onTap: () {},
                    width: 260,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: KraftsColors.dashboardPurple,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _NavItem(icon: Icons.home_rounded, label: 'Home'),
                _NavItem(icon: Icons.groups_rounded, label: 'Members'),
                _NavItem(icon: Icons.edit_calendar_rounded, label: 'Schedules'),
                _NavItem(icon: Icons.work_rounded, label: "Job's"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoText(String text, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: KraftsColors.dashboardPurple),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: KraftsColors.label,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback onTap,
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [KraftsColors.purpleDeep, KraftsColors.purpleLight],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTopBar extends StatelessWidget {
  const _ProfileTopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 54,
        color: KraftsColors.dashboardPurple,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: Colors.white,
              iconSize: 18,
              splashRadius: 20,
            ),
            // const _TopIconLabel(icon: Icons.person, label: 'Profile'),
            Expanded(
              child: Center(
                child: Text(
                  'Your Profile',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // const _TopIconLabel(
            //   icon: Icons.chat_bubble_rounded,
            //   label: "Chat's",
            // ),
          ],
        ),
      ),
    );
  }
}

class _TopIconLabel extends StatelessWidget {
  const _TopIconLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}

class _GalleryBox extends StatelessWidget {
  const _GalleryBox();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: KraftsColors.dashboardPurple.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 20, color: KraftsColors.dashboardPurple),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 21),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
