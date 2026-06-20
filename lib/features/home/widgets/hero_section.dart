import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/common/custom_button.dart';
import '../../../../core/widgets/common/placeholder_image.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return SizedBox(
      height: isMobile ? size.height * 0.85 : size.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hero/hero_photo.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => const PlaceholderImage(
              label: 'Hero fotografia\n(TODO: umiestniť hero_photo.jpg)',
            ),
          ),

          // Dark gradient overlay for text legibility
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xCC2C2C2C),
                  Color(0x552C2C2C),
                ],
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 32 : 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.heroSubtitle.toUpperCase(),
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.primaryPink,
                    letterSpacing: 4,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideY(begin: 0.15, end: 0),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    AppStrings.tagline,
                    style: isMobile
                        ? AppTextStyles.headingLarge
                            .copyWith(color: AppColors.white)
                        : AppTextStyles.displayMedium
                            .copyWith(color: AppColors.white),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .slideY(begin: 0.15, end: 0),
                const SizedBox(height: 44),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    CustomButton(
                      label: AppStrings.heroCtaBook,
                      // TODO: launch Fresha / Notino booking URL
                      onTap: () {},
                    ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                    CustomButton(
                      label: AppStrings.heroCtaServices,
                      variant: ButtonVariant.outlined,
                      textColor: AppColors.primaryPink,
                      onTap: () => context.go(AppRoutes.services),
                    ).animate().fadeIn(duration: 600.ms, delay: 900.ms),
                  ],
                ),
              ],
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Scrolovať',
                  style: AppTextStyles.label
                      .copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 6),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.white,
                  size: 20,
                ),
              ],
            )
                .animate(onPlay: (c) => c.repeat())
                .slideY(
                  begin: 0,
                  end: 0.25,
                  duration: 900.ms,
                  curve: Curves.easeInOut,
                ),
          ),
        ],
      ),
    );
  }
}
