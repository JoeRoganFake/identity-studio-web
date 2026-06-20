import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

enum ButtonVariant { filled, outlined, ghost }

const _kButtonWidth = 200.0;
const _kButtonHeight = 52.0;

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = ButtonVariant.filled,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyles.label.copyWith(letterSpacing: 2);

    switch (variant) {
      case ButtonVariant.filled:
        return SizedBox(
          width: _kButtonWidth,
          height: _kButtonHeight,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPink,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              elevation: 0,
            ),
            child: Text(
              label.toUpperCase(),
              style: labelStyle.copyWith(color: AppColors.white),
            ),
          ),
        );

      case ButtonVariant.outlined:
        return _OutlinedHoverButton(
          label: label,
          onTap: onTap,
          labelStyle: labelStyle,
          textColor: textColor ?? AppColors.darkText,
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

class _OutlinedHoverButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final TextStyle labelStyle;
  final Color textColor;

  const _OutlinedHoverButton({
    required this.label,
    required this.onTap,
    required this.labelStyle,
    required this.textColor,
  });

  @override
  State<_OutlinedHoverButton> createState() => _OutlinedHoverButtonState();
}

class _OutlinedHoverButtonState extends State<_OutlinedHoverButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fill;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fill = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(_) => _controller.forward();
  void _onExit(_) => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: _kButtonWidth,
          height: _kButtonHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Slide-fill layer (left → right)
              AnimatedBuilder(
                animation: _fill,
                builder: (_, __) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _fill.value,
                  child: Container(color: AppColors.primaryPink),
                ),
              ),
              // Border
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryPink),
                ),
              ),
              // Label
              Center(
                child: AnimatedBuilder(
                  animation: _fill,
                  builder: (_, __) => Text(
                    widget.label.toUpperCase(),
                    style: widget.labelStyle.copyWith(
                      color: _fill.value > 0.5
                          ? AppColors.white
                          : widget.textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
