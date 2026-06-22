import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/common/section_title.dart';
import '../../../core/widgets/common/placeholder_image.dart';
import '../../../core/widgets/common/page_wrapper.dart';
import '../../../core/widgets/common/custom_button.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  static const List<_ServiceDetail> _services = [
    _ServiceDetail(
      name: AppStrings.serviceManicure,
      shortDesc: AppStrings.serviceManicureDesc,
      longDesc: AppStrings.serviceManicureLong,
      icon: Icons.brush,
      imagePath: 'assets/images/services/manikura.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.servicePedicure,
      shortDesc: AppStrings.servicePedicureDesc,
      longDesc: AppStrings.servicePedicureLong,
      icon: Icons.spa,
      imagePath: 'assets/images/services/pedikura.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.serviceWomensHair,
      shortDesc: AppStrings.serviceWomensHairDesc,
      longDesc: AppStrings.serviceWomensHairLong,
      icon: Icons.face,
      imagePath: 'assets/images/services/vlasy.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.serviceMensHair,
      shortDesc: AppStrings.serviceMensHairDesc,
      longDesc: AppStrings.serviceMensHairLong,
      icon: Icons.content_cut,
      imagePath: 'assets/images/services/vlasy2.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.serviceBeauty,
      shortDesc: AppStrings.serviceBeautyDesc,
      longDesc: AppStrings.serviceBeautyLong,
      icon: Icons.star_outline,
      imagePath: 'assets/images/services/style.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return PageWrapper(
      children: [
        // Page header
        Container(
          color: AppColors.lightBlush,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: const SectionTitle(
            label: AppStrings.servicesSectionLabel,
            title: AppStrings.servicesSectionTitle,
          ),
        ),
        // Service detail cards
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: Column(
            children: _services
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: _ServiceDetailRow(
                      service: e.value,
                      reversed: !isMobile && e.key.isOdd,
                      isMobile: isMobile,
                    ).animate().fadeIn(
                          delay: Duration(milliseconds: 80 * e.key),
                        ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ServiceDetailRow extends StatelessWidget {
  final _ServiceDetail service;
  final bool reversed;
  final bool isMobile;

  const _ServiceDetailRow({
    required this.service,
    required this.reversed,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final textBlock = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(service.icon, size: 32, color: AppColors.accent),
          const SizedBox(height: 16),
          Text(service.name, style: AppTextStyles.headingMedium),
          const SizedBox(height: 16),
          Text(service.shortDesc, style: AppTextStyles.bodyMuted),
          const SizedBox(height: 12),
          Text(service.longDesc, style: AppTextStyles.bodyLarge),
          const SizedBox(height: 28),
          CustomButton(
            label: AppStrings.bookNow,
            onTap: () async {
              // Analytics log
              // await AnalyticsService().logReservationAttempt('fresha');
            },
          ),
        ],
      ),
    );

    final imageBlock = Expanded(
      child: SizedBox(
        height: 300,
        child: service.imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  service.imagePath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : PlaceholderImage(label: '${service.name}\nfotografia (TODO)'),
      ),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [imageBlock, const SizedBox(height: 28), textBlock],
      );
    }

    final spacer = const SizedBox(width: 60);
    final children = [textBlock, spacer, imageBlock];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: reversed ? children.reversed.toList() : children,
    );
  }
}

class _ServiceDetail {
  final String name;
  final String shortDesc;
  final String longDesc;
  final IconData icon;
  final String? imagePath;

  const _ServiceDetail({
    required this.name,
    required this.shortDesc,
    required this.longDesc,
    required this.icon,
    this.imagePath,
  });
}
