import 'package:flutter/material.dart';
import '../../core/widgets/common/page_wrapper.dart';
import 'widgets/hero_section.dart';
import 'widgets/services_section.dart';
import 'widgets/about_section.dart';
import 'widgets/gallery_preview_section.dart';
import 'widgets/reviews_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      children: [
        HeroSection(),
        ServicesSection(),
        AboutSection(),
        GalleryPreviewSection(),
        ReviewsSection(),
      ],
    );
  }
}
