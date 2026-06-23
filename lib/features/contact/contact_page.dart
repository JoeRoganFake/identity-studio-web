import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
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

class _ContactInfo extends StatefulWidget {
  const _ContactInfo();

  @override
  State<_ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<_ContactInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kontaktné informácie', style: AppTextStyles.headingMedium),
        const SizedBox(height: 32),
        _ContactRow(
          icon: Icons.phone_outlined,
          label: 'Manikúra & Pedikúra',
          value: AppStrings.contactPhoneManicure,
          onTap: () async {
            final url = Uri.parse('tel:+421911336560');
            if (await canLaunchUrl(url)) await launchUrl(url);
          },
        ),
        _ContactRow(
          icon: Icons.phone_outlined,
          label: 'Kaderníctvo',
          value: AppStrings.contactPhoneHair,
          onTap: () async {
            final url = Uri.parse('tel:+421940830509');
            if (await canLaunchUrl(url)) await launchUrl(url);
          },
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
          value: AppStrings.contactAddress,
          onTap: () async {
            final url = Uri.parse(AppStrings.contactMapsUrl);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
        const SizedBox(height: 32),
        Text('Sociálne siete', style: AppTextStyles.headingSmall),
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
        CustomButton(
          label: AppStrings.contactBooking,
          onTap: () => _showBookingDialog(context),
        ),
      ],
    );
  }

  void _showBookingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: AppColors.lightBlush,
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logos/logocenter.png',
              height: 90,
            ),
            const SizedBox(height: 32),
            Text(
              'Rezervovať termín',
              style: AppTextStyles.headingMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Vyberte typ služby',
              style: AppTextStyles.bodyMuted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Manikúra & Pedikúra',
                variant: ButtonVariant.outlined,
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final url = Uri.parse(AppStrings.bookingUrlManicure);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Kaderníctvo',
                variant: ButtonVariant.outlined,
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final url = Uri.parse(AppStrings.bookingUrlHair);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'Zrušiť',
                style: AppTextStyles.bodyMuted,
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).viewInsets.bottom),
          ],
        ),
      ),
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
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(AppStrings.contactMapsUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        height: 440,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            SizedBox.expand(
              child: HtmlElementView(
                viewType: 'google-maps-iframe',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
