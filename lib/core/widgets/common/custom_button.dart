import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

enum ButtonVariant { filled, outlined, ghost }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final ButtonVariant variant;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = ButtonVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.label.copyWith(letterSpacing: 2);

    switch (variant) {
      case ButtonVariant.filled:
        return ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPink,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            elevation: 0,
          ),
          child: Text(
            label.toUpperCase(),
            style: labelStyle.copyWith(color: AppColors.white),
          ),
        );

      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkText,
            side: const BorderSide(color: AppColors.primaryPink),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Text(label.toUpperCase(), style: labelStyle),
        );

      case ButtonVariant.ghost:
        return TextButton(
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.toUpperCase(),
                style: labelStyle.copyWith(color: AppColors.darkText),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
                size: 14,
                color: AppColors.accent,
              ),
            ],
          ),
        );
    }
  }
}
