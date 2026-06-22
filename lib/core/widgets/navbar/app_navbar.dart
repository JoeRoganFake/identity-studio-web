import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_strings.dart';
import 'navbar_scroll_notifier.dart';

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  static const double height = 80;

  static const List<_NavItem> _items = [
    _NavItem(label: AppStrings.navHome, route: AppRoutes.home),
    _NavItem(label: AppStrings.navServices, route: AppRoutes.services),
    _NavItem(label: AppStrings.navPricing, route: AppRoutes.pricing),
    _NavItem(label: AppStrings.navGallery, route: AppRoutes.gallery),
    _NavItem(label: AppStrings.navContact, route: AppRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return ValueListenableBuilder<bool>(
      valueListenable: navbarVisible,
      builder: (context, isVisible, _) {
        return AnimatedSlide(
          offset: isVisible ? Offset.zero : const Offset(0, -1),
          duration: const Duration(milliseconds: 320),
          curve: isVisible ? Curves.easeOut : Curves.easeIn,
          child: ValueListenableBuilder<bool>(
            valueListenable: navbarScrolled,
            builder: (context, isScrolled, _) {
              return ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: height,
                    decoration: BoxDecoration(
                      color: isScrolled
                          ? AppColors.lightBlush.withValues(alpha: 0.72)
                          : Colors.white.withValues(alpha: 0.65),
                      boxShadow: isScrolled
                          ? [
                              BoxShadow(
                                color: AppColors.primaryPink.withValues(alpha: 0.25),
                                blurRadius: 24,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                      border: Border(
                        bottom: BorderSide(
                          color: isScrolled
                              ? AppColors.primaryPink.withValues(alpha: 0.20)
                              : AppColors.border.withValues(alpha: 0.60),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 24),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => context.go(AppRoutes.home),
                            child: Image.asset(
                              'assets/images/logos/logow.png',
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (isMobile)
                          Builder(
                            builder: (ctx) => IconButton(
                              icon: const Icon(Icons.menu, color: AppColors.darkText),
                              onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                            ),
                          )
                        else ...[
                          ..._items.map((item) => _NavLink(item: item, headerScrolled: isScrolled)),
                          const SizedBox(width: 32),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _NavLink extends StatefulWidget {
  final _NavItem item;
  final bool headerScrolled;
  const _NavLink({required this.item, this.headerScrolled = false});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final currentUri = GoRouterState.of(context).uri.toString();
    final isActive = currentUri == widget.item.route;
    final highlight = isActive || _hovering;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                style: AppTextStyles.navLink.copyWith(
                  color: highlight
                      ? AppColors.accent
                      : widget.headerScrolled
                          ? AppColors.darkText
                          : AppColors.darkText,
                ),
                child: Text(widget.item.label.toUpperCase()),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1,
                width: highlight ? 20 : 0,
                color: AppColors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String route;
  const _NavItem({required this.label, required this.route});
}
