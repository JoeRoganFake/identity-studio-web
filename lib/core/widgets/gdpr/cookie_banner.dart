import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class CookieBanner extends StatefulWidget {
  final VoidCallback onAcceptAll;
  final VoidCallback onAcceptEssential;

  const CookieBanner({
    super.key,
    required this.onAcceptAll,
    required this.onAcceptEssential,
  });

  @override
  State<CookieBanner> createState() => _CookieBannerState();
}

class _CookieBannerState extends State<CookieBanner> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.darkText.withOpacity(0.95),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.cookieBannerTitle,
                        style: AppTextStyles.headingSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.cookieBannerMessage,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isMobile) const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 4),

            // Links
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                InkWell(
                  onTap: () {
                    if (context.mounted) {
                      context.go(AppRoutes.cookiesPolicy);
                    }
                  },
                  child: Text(
                    AppStrings.cookiePolicyLink,
                    style: AppTextStyles.bodyMuted.copyWith(
                      color: AppColors.primaryPink,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: Colors.white30,
                ),
                InkWell(
                  onTap: () {
                    if (context.mounted) {
                      context.go(AppRoutes.privacyPolicy);
                    }
                  },
                  child: Text(
                    AppStrings.privacyPolicyLink,
                    style: AppTextStyles.bodyMuted.copyWith(
                      color: AppColors.primaryPink,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Buttons
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(
                    label: AppStrings.cookieAcceptAll,
                    onPressed: widget.onAcceptAll,
                    isPrimary: true,
                  ),
                  const SizedBox(height: 8),
                  _buildButton(
                    label: AppStrings.cookieAcceptEssential,
                    onPressed: widget.onAcceptEssential,
                    isPrimary: false,
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildButton(
                    label: AppStrings.cookieAcceptEssential,
                    onPressed: widget.onAcceptEssential,
                    isPrimary: false,
                  ),
                  const SizedBox(width: 12),
                  _buildButton(
                    label: AppStrings.cookieAcceptAll,
                    onPressed: widget.onAcceptAll,
                    isPrimary: true,
                  ),
                ],
              ),
          ],
        ),
      );
    }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      height: 52,
      child: Material(
        color: isPrimary ? AppColors.primaryPink : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              border: isPrimary
                  ? null
                  : Border.all(color: Colors.white30, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              label,
              style: AppTextStyles.bodyLarge.copyWith(
                color: isPrimary ? Colors.white : Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
