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

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 88,
      ),
      child: isMobile ? _buildMobile(context) : _buildDesktop(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                label: AppStrings.aboutSectionLabel,
                title: AppStrings.aboutTitle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 28),
              Text(AppStrings.aboutText1, style: AppTextStyles.bodyLarge),
              const SizedBox(height: 16),
              Text(AppStrings.aboutText2, style: AppTextStyles.bodyLarge),
              const SizedBox(height: 36),
              CustomButton(
                label: AppStrings.aboutCtaMore,
                variant: ButtonVariant.ghost,
                onTap: () => context.go(AppRoutes.services),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideX(begin: -0.04, end: 0),
        ),
        const SizedBox(width: 72),
        Expanded(
          child: SizedBox(
            height: 480,
            child: Image.asset(
              'assets/images/hero/hero_photo.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const PlaceholderImage(
                label: 'Fotografia salónu\n(TODO: umiestniť hero_photo.jpg)',
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideX(begin: 0.04, end: 0),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About image (mobile)
        SizedBox(
          height: 280,
          child: Image.asset(
            'assets/images/hero/hero_photo.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, __, ___) => const PlaceholderImage(
              label: 'Fotografia salónu\n(TODO: umiestniť hero_photo.jpg)',
            ),
          ),
        ),
        const SizedBox(height: 40),
        const SectionTitle(
          label: AppStrings.aboutSectionLabel,
          title: AppStrings.aboutTitle,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 24),
        Text(AppStrings.aboutText1, style: AppTextStyles.bodyLarge),
        const SizedBox(height: 16),
        Text(AppStrings.aboutText2, style: AppTextStyles.bodyLarge),
        const SizedBox(height: 36),
        CustomButton(
          label: AppStrings.aboutCtaMore,
          variant: ButtonVariant.ghost,
          onTap: () => context.go(AppRoutes.services),
        ),
      ],
    );
  }
}
