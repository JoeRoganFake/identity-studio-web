import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/common/page_wrapper.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return PageWrapper(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            isMobile ? 24 : 80,
            100,
            isMobile ? 24 : 80,
            60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppStrings.privacyPolicyTitle,
                style: AppTextStyles.displayMedium.copyWith(
                  fontSize: isMobile ? 32 : 48,
                ),
              ),
              const SizedBox(height: 12),

              // Last updated
              Text(
                '${AppStrings.privacyPolicyLastUpdated}23. junia 2026',
                style: AppTextStyles.bodyMuted,
              ),
              const SizedBox(height: 48),

              // Content
              _buildContent(context),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final lines = AppStrings.privacyPolicyContent.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < lines.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildTextLine(lines[i]),
          ),
      ],
    );
  }

  Widget _buildTextLine(String line) {
    if (line.isEmpty) {
      return const SizedBox(height: 12);
    }

    // Check if it's a heading (number followed by dot and text)
    if (RegExp(r'^\d+\.').hasMatch(line)) {
      return Text(
        line,
        style: AppTextStyles.headingMedium.copyWith(
          color: AppColors.darkText,
        ),
      );
    }

    // Check if it's a bullet point
    if (line.startsWith('•')) {
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          line,
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    // Regular text
    return Text(
      line,
      style: AppTextStyles.bodyMedium,
    );
  }
}
