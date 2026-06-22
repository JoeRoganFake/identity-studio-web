import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/common/section_title.dart';
import '../../../../core/widgets/common/custom_button.dart';
import '../../../../core/widgets/common/placeholder_image.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const List<_ServiceData> _services = [
    _ServiceData(
      index: 0,
      name: AppStrings.serviceManicure,
      desc: AppStrings.serviceManicureDesc,
      icon: Icons.brush,
      imagePath: 'assets/images/services/manikura.jpg',
    ),
    _ServiceData(
      index: 1,
      name: AppStrings.servicePedicure,
      desc: AppStrings.servicePedicureDesc,
      icon: Icons.spa,
      imagePath: 'assets/images/services/pedikura.jpg',
    ),
    _ServiceData(
      index: 2,
      name: AppStrings.serviceWomensHair,
      desc: AppStrings.serviceWomensHairDesc,
      icon: Icons.content_cut,
      imagePath: 'assets/images/services/vlasy.jpg',
    ),
    _ServiceData(
      index: 3,
      name: AppStrings.serviceMensHair,
      desc: AppStrings.serviceMensHairDesc,
      icon: Icons.content_cut,
      imagePath: 'assets/images/services/vlasy2.jpg',
    ),
    _ServiceData(
      index: 4,
      name: AppStrings.serviceBeauty,
      desc: AppStrings.serviceBeautyDesc,
      icon: Icons.star_outline,
      imagePath: 'assets/images/services/style.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppColors.cream,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 88,
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: AppStrings.servicesSectionLabel,
            title: AppStrings.servicesSectionTitle,
          ),
          const SizedBox(height: 64),
          isMobile ? _buildMobile(context) : _buildDesktop(context),
          const SizedBox(height: 52),
          CustomButton(
            label: AppStrings.servicesViewAll,
            variant: ButtonVariant.outlined,
            onTap: () => context.go(AppRoutes.services),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    // Fixed 3-2 layout: 3 cards on top, 2 on bottom
    // 3 * 260 (card width) + 2 * 24 (spacing) = 828px
    const containerWidth = 828.0;
    
    return Center(
      child: SizedBox(
        width: containerWidth,
        child: Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: _services
              .asMap()
              .entries
              .map(
                (e) => _ScrollReveal(
                  index: e.key,
                  delay: Duration(milliseconds: 120 * e.key),
                  child: _ServiceCard(
                    service: e.value,
                    onTap: () => context.go(
                      '${AppRoutes.services}?service=${e.value.index}',
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: _services
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ScrollReveal(
                index: e.key,
                delay: Duration(milliseconds: 80 * e.key),
                child: _ServiceCard(
                  service: e.value,
                  fullWidth: true,
                  onTap: () => context.go(
                    '${AppRoutes.services}?service=${e.value.index}',
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final int index;
  const _ScrollReveal({
    required this.child,
    required this.index,
    this.delay = Duration.zero,
  });

  @override
  State<_ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<_ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  // Alternate: even-index cards slide from left, odd from right
  Offset get _hiddenOffset =>
      widget.index.isEven ? const Offset(-0.08, 0.06) : const Offset(0.08, 0.06);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.92, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    _slide = Tween<Offset>(begin: _hiddenOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(widget.delay, () {
          if (mounted) _ctrl.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: SlideTransition(position: _slide, child: widget.child,
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _ServiceData service;
  final bool fullWidth;
  final VoidCallback? onTap;

  const _ServiceCard({required this.service, this.fullWidth = false, this.onTap});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.fullWidth ? double.infinity : 260.0;
    final cardHeight = 480.0;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? AppColors.primaryPink.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.07),
              blurRadius: _hovering ? 24 : 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: _hovering
                ? AppColors.primaryPink
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vertical image — taller for portrait feel
              SizedBox(
                height: 240,
                width: double.infinity,
                child: widget.service.imagePath != null
                    ? Image.asset(
                        widget.service.imagePath!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => PlaceholderImage(
                          label: '${widget.service.name}\nfotografia (TODO)',
                        ),
                      )
                    : PlaceholderImage(
                        label: '${widget.service.name}\nfotografia (TODO)',
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPink.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              widget.service.icon,
                              size: 20,
                              color: AppColors.primaryPink,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.service.name,
                              style: AppTextStyles.headingSmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(widget.service.desc, style: AppTextStyles.bodyMuted),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _ServiceData {
  final String name;
  final String desc;
  final IconData icon;
  final String? imagePath;
  final int index;

  const _ServiceData({
    required this.index,
    required this.name,
    required this.desc,
    required this.icon,
    this.imagePath,
  });
}
