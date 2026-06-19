import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/section_title.dart';
import '../../../../core/widgets/common/placeholder_image.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  // TODO: Replace with real team member names, roles, and profile photos
  static const List<_TeamMember> _team = [
    _TeamMember(name: 'Jana Nováková', role: 'Manikúra & Pedikúra'),
    _TeamMember(name: 'Mária Kováčová', role: 'Dámske kaderníctvo'),
    _TeamMember(name: 'Petra Horváthová', role: 'Beauty špecialistka'),
    _TeamMember(name: 'Tomáš Sloboda', role: 'Pánske kaderníctvo'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 88,
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: AppStrings.teamSectionLabel,
            title: AppStrings.teamSectionTitle,
          ),
          const SizedBox(height: 64),
          isMobile ? _buildMobile() : _buildDesktop(),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _team
          .asMap()
          .entries
          .map(
            (e) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _TeamCard(member: e.value).animate().fadeIn(
                      delay: Duration(milliseconds: 120 * e.key),
                    ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMobile() {
    return Column(
      children: _team
          .map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _TeamCard(member: m, horizontal: true),
            ),
          )
          .toList(),
    );
  }
}

class _TeamCard extends StatelessWidget {
  final _TeamMember member;
  final bool horizontal;

  const _TeamCard({required this.member, this.horizontal = false});

  @override
  Widget build(BuildContext context) {
    if (horizontal) {
      return Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            // TODO: Replace with team member profile photo
            child: PlaceholderImage(label: member.name[0]),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.name, style: AppTextStyles.headingSmall),
              const SizedBox(height: 4),
              Text(member.role, style: AppTextStyles.bodyMuted),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 260,
          // TODO: Replace with team member profile photo
          child: PlaceholderImage(
            label: '${member.name}\n(TODO: pridať foto)',
          ),
        ),
        const SizedBox(height: 20),
        Text(member.name, style: AppTextStyles.headingSmall),
        const SizedBox(height: 4),
        Text(member.role, style: AppTextStyles.bodyMuted),
      ],
    );
  }
}

class _TeamMember {
  final String name;
  final String role;

  const _TeamMember({required this.name, required this.role});
}
