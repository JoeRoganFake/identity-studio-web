import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/common/section_title.dart';
import '../../../core/widgets/common/custom_button.dart';
import '../../../core/widgets/common/page_wrapper.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
          child: const SectionTitle(
            label: AppStrings.contactSectionLabel,
            title: AppStrings.contactSectionTitle,
          ),
        ),
        // Contact content
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: isMobile
              ? _buildMobile()
              : _buildDesktop(),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ContactInfo()
              .animate()
              .fadeIn(duration: 600.ms),
        ),
        const SizedBox(width: 60),
        Expanded(
          child: _MapPlaceholder()
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactInfo(),
        const SizedBox(height: 48),
        _MapPlaceholder(),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kontaktné informácie', style: AppTextStyles.headingMedium),
        const SizedBox(height: 32),
        _ContactRow(
          icon: Icons.phone_outlined,
          label: 'Telefón',
          value: AppStrings.contactPhone, // TODO: real phone number
          // TODO: launch tel:+421XXXXXXXXX
          onTap: () {},
        ),
        _ContactRow(
          icon: Icons.email_outlined,
          label: 'E-mail',
          value: AppStrings.contactEmail, // TODO: real email
          // TODO: launch mailto:info@identitystudio.sk
          onTap: () {},
        ),
        _ContactRow(
          icon: Icons.location_on_outlined,
          label: 'Adresa',
          value: AppStrings.contactAddress, // TODO: real address
          // TODO: launch Google Maps URL
          onTap: () {},
        ),
        const SizedBox(height: 32),
        Text('Sociálne siete', style: AppTextStyles.headingSmall),
        const SizedBox(height: 16),
        GestureDetector(
          // TODO: open https://www.instagram.com/identity_beauty_studio
          onTap: () {},
          child: Row(
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 20,
                color: AppColors.accent,
              ),
              const SizedBox(width: 12),
              Text(
                AppStrings.contactInstagram,
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.accent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text('Pracovná doba', style: AppTextStyles.headingSmall),
        const SizedBox(height: 16),
        // TODO: Confirm real opening hours with the salon
        ...AppStrings.openingHours.map(
          (h) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  child: Text(h.$1, style: AppTextStyles.bodyMuted),
                ),
                Text(h.$2, style: AppTextStyles.bodyLarge),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        CustomButton(
          label: AppStrings.contactBooking,
          // TODO: launch Fresha / Notino booking URL
          onTap: () {},
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.lightBlush,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: AppColors.accent),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.label),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.bodyLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with a Google Maps embed (WebView / iframe via HtmlElementView on web)
    return Container(
      height: 440,
      decoration: BoxDecoration(
        color: AppColors.lightBlush,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.map_outlined, size: 48, color: AppColors.accent),
          const SizedBox(height: 16),
          Text(
            'Google Maps\n(TODO: pridať mapu)',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMuted,
          ),
        ],
      ),
    );
  }
}
