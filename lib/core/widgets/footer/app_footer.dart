import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_routes.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  static const List<(String, String)> _navLinks = [
    (AppStrings.navHome, AppRoutes.home),
    (AppStrings.navServices, AppRoutes.services),
    (AppStrings.navPricing, AppRoutes.pricing),
    (AppStrings.navGallery, AppRoutes.gallery),
    (AppStrings.navContact, AppRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppColors.darkText,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 28 : 80,
        vertical: 64,
      ),
      child: isMobile ? _buildMobile(context) : _buildDesktop(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildBrand()),
            const SizedBox(width: 48),
            Expanded(child: _buildNavLinks(context)),
            const SizedBox(width: 48),
            Expanded(flex: 2, child: _buildContact()),
          ],
        ),
        const SizedBox(height: 48),
        Container(height: 1, color: const Color(0xFF3A3A3A)),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              AppStrings.footerRights,
              style: AppTextStyles.bodyMuted.copyWith(
                color: const Color(0xFF6E6E6E),
                fontSize: 12,
              ),
            ),
            const Spacer(),
            _footerLink(AppStrings.footerGdpr, () {}), // TODO: GDPR page
            const SizedBox(width: 24),
            _footerLink(AppStrings.footerCookies, () {}), // TODO: Cookies policy
          ],
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrand(),
        const SizedBox(height: 40),
        _buildContact(),
        const SizedBox(height: 40),
        Container(height: 1, color: const Color(0xFF3A3A3A)),
        const SizedBox(height: 24),
        Text(
          AppStrings.footerRights,
          style: AppTextStyles.bodyMuted.copyWith(
            color: const Color(0xFF6E6E6E),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.appName,
          style: AppTextStyles.headingMedium.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.tagline,
          style: AppTextStyles.bodyMuted.copyWith(
            color: const Color(0xFF8C8C8C),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.website,
          style: AppTextStyles.bodyMuted.copyWith(color: AppColors.primaryPink),
        ),
      ],
    );
  }

  Widget _buildNavLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NAVIGÁCIA',
          style: AppTextStyles.label.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 20),
        ..._navLinks.map(
          (l) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => context.go(l.$2),
              child: Text(
                l.$1,
                style: AppTextStyles.bodyMuted
                    .copyWith(color: const Color(0xFF8C8C8C)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KONTAKT',
          style: AppTextStyles.label.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 20),
        _contactRow(Icons.phone_outlined, AppStrings.contactPhone),
        _contactRow(Icons.email_outlined, AppStrings.contactEmail),
        _contactRow(Icons.location_on_outlined, AppStrings.contactAddress),
        const SizedBox(height: 12),
        GestureDetector(
          // TODO: open https://www.instagram.com/identity_beauty_studio
          onTap: () {},
          child: Text(
            AppStrings.contactInstagram,
            style: AppTextStyles.bodyMuted.copyWith(color: AppColors.primaryPink),
          ),
        ),
      ],
    );
  }

  Widget _contactRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: AppColors.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMuted
                  .copyWith(color: const Color(0xFF8C8C8C)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyles.bodyMuted.copyWith(
          color: const Color(0xFF6E6E6E),
          fontSize: 12,
          decoration: TextDecoration.underline,
          decorationColor: const Color(0xFF6E6E6E),
        ),
      ),
    );
  }
}
