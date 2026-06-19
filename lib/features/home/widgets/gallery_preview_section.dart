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

class GalleryPreviewSection extends StatelessWidget {
  const GalleryPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final photoCount = isMobile ? 4 : 6;

    return Container(
      color: AppColors.lightBlush,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 88,
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: AppStrings.gallerySectionLabel,
            title: AppStrings.gallerySectionTitle,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            // TODO: open https://www.instagram.com/identity_beauty_studio
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  size: 14,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 8),
                Text(
                  AppStrings.galleryInstagramHandle,
                  style: AppTextStyles.bodyMuted.copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 52),
          // TODO: Replace all placeholders with real gallery images
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 3,
              crossAxisSpacing: isMobile ? 8 : 12,
              mainAxisSpacing: isMobile ? 8 : 12,
            ),
            itemCount: photoCount,
            itemBuilder: (_, i) => PlaceholderImage(
              label: 'Foto ${i + 1}\n(TODO)',
            ).animate().fadeIn(delay: Duration(milliseconds: 80 * i)),
          ),
          const SizedBox(height: 44),
          CustomButton(
            label: AppStrings.galleryViewAll,
            variant: ButtonVariant.outlined,
            onTap: () => context.go(AppRoutes.gallery),
          ),
        ],
      ),
    );
  }
}
