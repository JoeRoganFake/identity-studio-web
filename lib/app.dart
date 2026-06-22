import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/constants/app_routes.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/navbar/app_navbar.dart';
import 'core/widgets/navbar/mobile_drawer.dart';
import 'features/home/home_page.dart';
import 'features/services/services_page.dart';
import 'features/pricing/pricing_page.dart';
import 'features/gallery/gallery_page.dart';
import 'features/contact/contact_page.dart';

final _router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => _AppShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (_, _) => const NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: AppRoutes.services,
          pageBuilder: (_, state) => NoTransitionPage(
            child: ServicesPage(
              focusServiceIndex: int.tryParse(
                state.uri.queryParameters['service'] ?? '',
              ),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.pricing,
          pageBuilder: (_, _) => const NoTransitionPage(child: PricingPage()),
        ),
        GoRoute(
          path: AppRoutes.gallery,
          pageBuilder: (_, _) => const NoTransitionPage(child: GalleryPage()),
        ),
        GoRoute(
          path: AppRoutes.contact,
          pageBuilder: (_, _) => const NoTransitionPage(child: ContactPage()),
        ),
     
       
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.light,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Shell wrapping every page with the shared navbar and end-drawer.
/// Each page handles its own scroll view and includes the footer via [PageWrapper].
class _AppShell extends StatelessWidget {
  final Widget child;

  const _AppShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MobileDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Page content fills the full viewport — navbar floats over it.
                // BackdropFilter samples this layer to create the frosted glass effect.
                RepaintBoundary(child: child),
                // Navbar floats on top and can slide out of view on scroll-down.
                const Positioned(top: 0, left: 0, right: 0, child: AppNavbar()),
              ],
            ),
          ),
          // GDPR banner at the bottom
        ],
      ),
    );
  }
}
