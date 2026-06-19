import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Placeholder for images that are not yet added.
/// TODO: Replace with real asset image or network image.
class PlaceholderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? label;
  final BoxFit fit;

  const PlaceholderImage({
    super.key,
    this.width,
    this.height,
    this.label,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.lightBlush,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image_outlined,
              size: 36,
              color: AppColors.accent,
            ),
            if (label != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  label!,
                  style: AppTextStyles.bodyMuted,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
