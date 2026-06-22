import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_strings.dart';
import '../common/logo_widget.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  static const List<_DrawerItem> _items = [
    _DrawerItem(label: AppStrings.navHome, route: AppRoutes.home),
    _DrawerItem(label: AppStrings.navServices, route: AppRoutes.services),
    _DrawerItem(label: AppStrings.navPricing, route: AppRoutes.pricing),
    _DrawerItem(label: AppStrings.navGallery, route: AppRoutes.gallery),
    _DrawerItem(label: AppStrings.navContact, route: AppRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cream,
      width: 280,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 20),
              child: const LogoHorizontal(markSize: 38),
            ),
            Container(height: 1, color: AppColors.border),
            const SizedBox(height: 16),
            ..._items.map((item) => _DrawerTile(item: item)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Text(
                AppStrings.footerRights,
                style: AppTextStyles.bodyMuted.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final _DrawerItem item;
  const _DrawerTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 2),
      title: Text(
        item.label.toUpperCase(),
        style: AppTextStyles.label.copyWith(
          fontSize: 12,
          letterSpacing: 2,
          color: AppColors.darkText,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        context.go(item.route);
      },
    );
  }
}

class _DrawerItem {
  final String label;
  final String route;
  const _DrawerItem({required this.label, required this.route});
}
