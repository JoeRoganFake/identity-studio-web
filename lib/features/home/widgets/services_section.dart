import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/common/section_title.dart';
import '../../../../core/widgets/common/custom_button.dart';
import '../../../../core/widgets/common/placeholder_image.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const List<_ServiceData> _services = [
    _ServiceData(
      name: AppStrings.serviceManicure,
      desc: AppStrings.serviceManicureDesc,
      icon: Icons.brush,
    ),
    _ServiceData(
      name: AppStrings.servicePedicure,
      desc: AppStrings.servicePedicureDesc,
      icon: Icons.spa,
    ),
    _ServiceData(
      name: AppStrings.serviceWomensHair,
      desc: AppStrings.serviceWomensHairDesc,
      icon: Icons.face,
    ),
    _ServiceData(
      name: AppStrings.serviceMensHair,
      desc: AppStrings.serviceMensHairDesc,
      icon: Icons.content_cut,
    ),
    _ServiceData(
      name: AppStrings.serviceBeauty,
      desc: AppStrings.serviceBeautyDesc,
      icon: Icons.star_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppColors.cream,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 88,
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: AppStrings.servicesSectionLabel,
            title: AppStrings.servicesSectionTitle,
          ),
          const SizedBox(height: 64),
          isMobile ? _buildMobile() : _buildDesktop(),
          const SizedBox(height: 52),
          CustomButton(
            label: AppStrings.servicesViewAll,
            variant: ButtonVariant.outlined,
            onTap: () => context.go(AppRoutes.services),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: _services
          .asMap()
          .entries
          .map(
            (e) => _ServiceCard(service: e.value).animate().fadeIn(
                  delay: Duration(milliseconds: 100 * e.key),
                  duration: 500.ms,
                ),
          )
          .toList(),
    );
  }

  Widget _buildMobile() {
    return Column(
      children: _services
          .map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ServiceCard(service: s, fullWidth: true),
            ),
          )
          .toList(),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _ServiceData service;
  final bool fullWidth;

  const _ServiceCard({required this.service, this.fullWidth = false});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.fullWidth ? double.infinity : 272,
        decoration: BoxDecoration(
          color: _hovering
              ? AppColors.primaryPink.withValues(alpha: 0.12)
              : AppColors.white,
          border: Border.all(
            color: _hovering ? AppColors.primaryPink : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Replace with real service image
            SizedBox(
              height: 160,
              child: PlaceholderImage(
                label: '${widget.service.name}\nfotografia (TODO)',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(widget.service.icon, size: 26, color: AppColors.accent),
                  const SizedBox(height: 12),
                  Text(widget.service.name, style: AppTextStyles.headingSmall),
                  const SizedBox(height: 8),
                  Text(widget.service.desc, style: AppTextStyles.bodyMuted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceData {
  final String name;
  final String desc;
  final IconData icon;

  const _ServiceData({
    required this.name,
    required this.desc,
    required this.icon,
  });
}
