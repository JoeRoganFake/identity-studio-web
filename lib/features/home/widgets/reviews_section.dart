import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/section_title.dart';
import '../../../../core/widgets/common/custom_button.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  // TODO: Replace with live data from Google Places API
  static const List<_Review> _reviews = [
    _Review(
      author: 'Medipodi Medipodi',
      text: 'Confi Hair- kristinka  mi robi každý mesiac tie najkrajšie vlasy. Profesionálne služby na jednom mieste a láskavý prístup. Top',
      stars: 5,
    ),
    _Review(
      author: 'Jakub Šašov',
      text: 'Velmi sikovna a prijemna pani kadernicka, hned pochopila, aky uces som si predstavoval. Odisiel som velmi spokojny.',
      stars: 5,
    ),
    _Review(
      author: 'Mária Štellárová',
      text: 'Top! Odporúčam každému nechty aj vlasy.',
      stars: 5,
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
            label: AppStrings.reviewsSectionLabel,
            title: AppStrings.reviewsSectionTitle,
          ),
          const SizedBox(height: 64),
          isMobile ? _buildMobile() : _buildDesktop(),
          const SizedBox(height: 44),
          CustomButton(
            label: AppStrings.reviewsGoogleLink,
            variant: ButtonVariant.ghost,
            onTap: () async {
              final url = Uri.parse(AppStrings.reviewsGoogleUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _reviews
          .asMap()
          .entries
          .map(
            (e) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _ReviewCard(review: e.value).animate().fadeIn(
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
      children: _reviews
          .map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ReviewCard(review: r),
            ),
          )
          .toList(),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final _Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              review.stars,
              (_) => const Icon(
                Icons.star,
                size: 16,
                color: AppColors.primaryPink,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              '„${review.text}"',
              style: AppTextStyles.bodyLarge.copyWith(fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text('— ${review.author}', style: AppTextStyles.bodyMuted),
        ],
      ),
    );
  }
}

class _Review {
  final String author;
  final String text;
  final int stars;

  const _Review({
    required this.author,
    required this.text,
    required this.stars,
  });
}
