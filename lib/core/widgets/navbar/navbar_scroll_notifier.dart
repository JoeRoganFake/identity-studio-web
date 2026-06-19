import 'package:flutter/foundation.dart';

/// Shared notifiers updated by [PageWrapper] and consumed by [AppNavbar].
final ValueNotifier<bool> navbarScrolled = ValueNotifier(false);

/// True when the navbar should be visible (scroll up / at top), false when hidden (scroll down).
final ValueNotifier<bool> navbarVisible = ValueNotifier(true);
