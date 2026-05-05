import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'krafts_design.dart';
import 'profile_screen.dart';

enum MemberFilter { all, paid, verified, unverified }

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key, this.embedded = false, this.onBack});

  final bool embedded;
  final VoidCallback? onBack;

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  static const Color _pageBg = Color(0xFFF6F2FF);
  MemberFilter _filter = MemberFilter.all;

  final List<_Member> _members = const [
    _Member(
      name: 'Pavan Vijay Kumar M',
      role: 'Director , Actor , Dancer',
      city: 'Vijayawada',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=60',
    ),
    _Member(
      name: 'Pavan Vijay Kumar M',
      role: 'Director , Actor , Dancer',
      city: 'Vijayawada',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=60',
    ),
    _Member(
      name: 'Pavan Vijay Kumar M',
      role: 'Director , Actor , Dancer',
      city: 'Vijayawada',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=60',
    ),
    _Member(
      name: 'Pavan Vijay Kumar M',
      role: 'Director , Actor , Dancer',
      city: 'Vijayawada',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=60',
    ),
    _Member(
      name: 'Pavan Vijay Kumar M',
      role: 'Director , Actor , Dancer',
      city: 'Vijayawada',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=60',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _MembersTopBar(
          title: 'Members',
          showBack: !widget.embedded,
          onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: KraftsColors.dashboardPurple.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _FilterPill(
                        label: 'All',
                        selected: _filter == MemberFilter.all,
                        onTap: () => setState(() => _filter = MemberFilter.all),
                      ),
                    ),
                    Expanded(
                      child: _FilterPill(
                        label: 'Paid',
                        selected: _filter == MemberFilter.paid,
                        onTap: () =>
                            setState(() => _filter = MemberFilter.paid),
                      ),
                    ),
                    Expanded(
                      child: _FilterPill(
                        label: 'Verified',
                        selected: _filter == MemberFilter.verified,
                        onTap: () =>
                            setState(() => _filter = MemberFilter.verified),
                      ),
                    ),
                    Expanded(
                      child: _FilterPill(
                        label: 'UnVerified',
                        selected: _filter == MemberFilter.unverified,
                        onTap: () =>
                            setState(() => _filter = MemberFilter.unverified),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ..._members.map(
                (member) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _MemberCard(
                    member: member,
                    onChatTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (_) => ChattingScreen(member: member),
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
}

class _MembersTopBar extends StatelessWidget {
  const _MembersTopBar({
    required this.title,
    required this.showBack,
    required this.onBack,
  });

  final String title;
  final bool showBack;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 54,
        color: KraftsColors.dashboardPurple,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            // if (showBack)
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: Colors.white,
              iconSize: 18,
              splashRadius: 18,
            ),
            // _TopIconLabel(
            //   icon: Icons.person,
            //   label: 'Profile',
            //   onTap: () {
            //     Navigator.of(context).push<void>(
            //       MaterialPageRoute<void>(
            //         builder: (_) => const ProfileScreen(),
            //       ),
            //     );
            //   },
            // ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
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

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? KraftsColors.purpleDeep : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : KraftsColors.label,
          ),
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.onChatTap});

  final _Member member;
  final VoidCallback onChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8DCF8)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(member.imageUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: KraftsColors.headline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member.role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: KraftsColors.label,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: KraftsColors.dashboardPurple,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        member.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: KraftsColors.headline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onChatTap,
            borderRadius: BorderRadius.circular(24),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.forum_rounded,
                size: 34,
                color: KraftsColors.dashboardPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key, required this.member});

  final _Member member;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FF),
      body: Column(
        children: [
          _MembersTopBar(
            title: 'Chatting',
            showBack: true,
            onBack: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Text(
                          member.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: KraftsColors.headline,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(member.imageUrl),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _MessageBubble(
                    text: 'Hi Sir , How Are you',
                    isMine: true,
                  ),
                  const SizedBox(height: 14),
                  const _MessageBubble(
                    text: "i’m Good How About You",
                    isMine: false,
                  ),
                  const SizedBox(height: 14),
                  const _MessageBubble(
                    text: "i’m Good Sir Thanks for asking",
                    isMine: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.text, required this.isMine});

  final String text;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isMine
              ? KraftsColors.favoritePurple.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          textAlign: isMine ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF674D4D),
          ),
        ),
      ),
    );
  }
}

class _Member {
  const _Member({
    required this.name,
    required this.role,
    required this.city,
    required this.imageUrl,
  });

  final String name;
  final String role;
  final String city;
  final String imageUrl;
}
