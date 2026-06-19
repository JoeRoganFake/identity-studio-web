import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      author: 'Marta K.',
      text: 'Úžasný salón! Profesionálny prístup a krásne výsledky. Určite sa vrátim.',
      stars: 5,
    ),
    _Review(
      author: 'Lucia B.',
      text: 'Najlepšia manikúra v meste. Personál je milý a priestory sú nádherné.',
      stars: 5,
    ),
    _Review(
      author: 'Zuzana M.',
      text: 'Veľmi spokojná s farebnými vlasmi. Kaderníčka ma vypočula a splnila moje predstavy.',
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
            // TODO: open Google Reviews URL
            onTap: () {},
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
          Text(
            '„${review.text}"',
            style: AppTextStyles.bodyLarge.copyWith(fontStyle: FontStyle.italic),
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
