import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'core/constants/app_routes.dart';
import 'core/constants/app_strings.dart';
import 'core/services/cookie_preferences_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/gdpr/cookie_banner.dart';
import 'core/widgets/navbar/app_navbar.dart';
import 'core/widgets/navbar/mobile_drawer.dart';
import 'features/home/home_page.dart';
import 'features/services/services_page.dart';
import 'features/pricing/pricing_page.dart';
import 'features/gallery/gallery_page.dart';
import 'features/contact/contact_page.dart';
import 'features/privacy_policy/privacy_policy_page.dart';
import 'features/cookies_policy/cookies_policy_page.dart';

final _router = GoRouter(
  initialLocation: AppRoutes.home,
  observers: [
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
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
        GoRoute(
          path: AppRoutes.privacyPolicy,
          pageBuilder: (_, _) =>
              const NoTransitionPage(child: PrivacyPolicyPage()),
        ),
        GoRoute(
          path: AppRoutes.cookiesPolicy,
          pageBuilder: (_, _) =>
              const NoTransitionPage(child: CookiesPolicyPage()),
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
class _AppShell extends StatefulWidget {
  final Widget child;

  const _AppShell({required this.child});

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  late final CookiePreferencesService _cookieService;
  bool _showCookieBanner = false;

  @override
  void initState() {
    super.initState();
    _cookieService = CookiePreferencesService();
    _checkCookieConsent();
  }

  void _checkCookieConsent() {
    // Show banner if user hasn't made a choice yet
    if (!_cookieService.preferences.hasMadeChoice) {
      _showCookieBanner = true;
    }
  }

  void _handleAcceptAll() {
    _cookieService.acceptAll();
    setState(() {
      _showCookieBanner = false;
    });
    // Enable Google Analytics for detailed tracking
    _enableAnalytics();
  }

  void _enableAnalytics() {
    try {
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
      // Log analytics acceptance event
      FirebaseAnalytics.instance.logEvent(
        name: 'gdpr_cookies_accepted',
        parameters: {
          'acceptance_type': 'all',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      debugPrint('Error initializing analytics: $e');
    }
  }

  void _handleAcceptEssential() {
    _cookieService.acceptEssential();
    setState(() {
      _showCookieBanner = false;
    });
    // Disable analytics when only essential cookies are accepted
    _disableAnalytics();
  }

  void _disableAnalytics() {
    try {
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
      // Log analytics rejection event
      FirebaseAnalytics.instance.logEvent(
        name: 'gdpr_cookies_rejected',
        parameters: {
          'acceptance_type': 'essential_only',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      debugPrint('Error disabling analytics: $e');
    }
  }

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
                RepaintBoundary(child: widget.child),
                // Navbar floats on top and can slide out of view on scroll-down.
                const Positioned(top: 0, left: 0, right: 0, child: AppNavbar()),
              ],
            ),
          ),
          // GDPR cookie banner at the bottom
          if (_showCookieBanner)
            CookieBanner(
              onAcceptAll: _handleAcceptAll,
              onAcceptEssential: _handleAcceptEssential,
            ),
        ],
      ),
    );
  }
}
