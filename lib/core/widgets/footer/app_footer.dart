import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_routes.dart';
import '../../services/scroll_to_top_service.dart';

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
            Expanded(flex: 2, child: _buildContact(context)),
          ],
        ),
        const SizedBox(height: 48),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 300,
            child: const UiKitView(viewType: 'google-maps-iframe'),
          ),
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
        _buildContact(context),
        const SizedBox(height: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 300,
            child: const UiKitView(viewType: 'google-maps-iframe'),
          ),
        ),
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
        Image.asset(
          'assets/images/logos/logomain.png',
          height: 160,
          fit: BoxFit.contain,
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
              onTap: () {
                if (l.$2 == AppRoutes.home) {
                  // Scroll to top when Home is tapped
                  scrollToTopService.scrollToTop();
                }
                context.go(l.$2);
              },
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

  Widget _buildContact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KONTAKT',
          style: AppTextStyles.label.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 20),
        _contactRow(Icons.phone_outlined, AppStrings.contactPhoneHair),
        _contactRow(Icons.email_outlined, AppStrings.contactEmail),
        _contactAddressRow(context),
        const SizedBox(height: 20),
        _mapLink(context),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final url = Uri.parse(
              'https://www.instagram.com/identity_beauty_studio/?hl=en',
            );
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: Text(
            AppStrings.contactInstagram,
            style: AppTextStyles.bodyMuted.copyWith(color: AppColors.primaryPink),
          ),
        ),
      ],
    );
  }

  Widget _contactAddressRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () async {
          // Copy address to clipboard
          await Clipboard.setData(
            const ClipboardData(text: AppStrings.contactAddress),
          );
          // Show snackbar feedback
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Adresa skopírovaná'),
                duration: const Duration(milliseconds: 1500),
              ),
            );
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, size: 14, color: AppColors.accent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppStrings.contactAddress,
                style: AppTextStyles.bodyMuted.copyWith(
                  color: AppColors.primaryPink,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapLink(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(AppStrings.contactMapsUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      child: Row(
        children: [
          Icon(Icons.map_outlined, size: 14, color: AppColors.primaryPink),
          const SizedBox(width: 8),
          Text(
            'Otvoriť na Google Maps',
            style: AppTextStyles.bodyMuted.copyWith(
              color: AppColors.primaryPink,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
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
