import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/common/section_title.dart';
import '../../../core/widgets/common/custom_button.dart';
import '../../../core/widgets/common/page_wrapper.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late List<String> _galleryImages;

  @override
  void initState() {
    super.initState();
    _galleryImages = [
      'assets/images/gallery/nechty.jpg',
      'assets/images/gallery/nechty2.jpg',
      'assets/images/gallery/vlasy.jpg',
      'assets/images/gallery/vlasy2.jpg',
      'assets/images/gallery/vlasy3.jpg',
      'assets/images/gallery/voutcher.jpg',
    ];
    _galleryImages.shuffle();
  }

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
          child: Column(
            children: [
              const SectionTitle(
                label: AppStrings.gallerySectionLabel,
                title: AppStrings.gallerySectionTitle,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://www.instagram.com/identity_beauty_studio/?hl=en',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
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
                      AppStrings.galleryInstagram,
                      style: AppTextStyles.bodyMuted
                          .copyWith(color: AppColors.accent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Photo grid
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 80,
            vertical: 60,
          ),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 3,
                  crossAxisSpacing: isMobile ? 8 : 12,
                  mainAxisSpacing: isMobile ? 8 : 12,
                ),
                itemCount: _galleryImages.length,
                itemBuilder: (_, i) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.cream,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      _galleryImages[i],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          'Image\nfailed',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMuted,
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)),
              ),
              const SizedBox(height: 52),
              CustomButton(
                label: AppStrings.galleryInstagram,
                variant: ButtonVariant.outlined,
                onTap: () async {
                  final url = Uri.parse(
                    'https://www.instagram.com/identity_beauty_studio/?hl=en',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
