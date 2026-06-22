import 'package:flutter/foundation.dart';

/// Service to trigger scroll-to-top events across the app
class ScrollToTopService extends ChangeNotifier {
  void scrollToTop() {
    notifyListeners();
  }
}

/// Global instance
final scrollToTopService = ScrollToTopService();
