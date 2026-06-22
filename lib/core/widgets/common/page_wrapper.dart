import 'package:flutter/material.dart';
import '../footer/app_footer.dart';
import '../navbar/navbar_scroll_notifier.dart';

/// Wraps each page's content in a scroll view and appends the footer.
class PageWrapper extends StatefulWidget {
  final List<Widget> children;

  const PageWrapper({super.key, required this.children});

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  double _lastPixels = 0;

  @override
  void initState() {
    super.initState();
    _lastPixels = 0;
    // Reset header scroll state after the current build phase completes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      navbarScrolled.value = false;
      navbarVisible.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final pixels = notification.metrics.pixels;
        navbarScrolled.value = pixels > 0;
        if (pixels <= 0) {
          navbarVisible.value = true;
        } else if (notification is ScrollUpdateNotification) {
          final delta = pixels - _lastPixels;
          if (delta > 4) navbarVisible.value = false;  // scrolling down
          if (delta < -4) navbarVisible.value = true;  // scrolling up
        }
        _lastPixels = pixels;
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...widget.children,
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
