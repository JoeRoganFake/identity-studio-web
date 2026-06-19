import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String label;
  final String title;
  final TextAlign textAlign;

  const SectionTitle({
    super.key,
    required this.label,
    required this.title,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxis = textAlign == TextAlign.left
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: crossAxis,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.label.copyWith(color: AppColors.accent),
          textAlign: textAlign,
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: AppTextStyles.headingLarge,
          textAlign: textAlign,
        ),
        const SizedBox(height: 16),
        Container(
          width: 40,
          height: 1.5,
          color: AppColors.primaryPink,
        ),
      ],
    );
  }
}
