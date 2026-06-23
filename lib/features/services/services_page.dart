import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/common/section_title.dart';
import '../../../core/widgets/common/placeholder_image.dart';
import '../../../core/widgets/common/page_wrapper.dart';
import '../../../core/widgets/common/custom_button.dart';

class ServicesPage extends StatefulWidget {
  final int? focusServiceIndex;

  const ServicesPage({super.key, this.focusServiceIndex});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  static const List<_ServiceDetail> _services = [
    _ServiceDetail(
      name: AppStrings.serviceManicure,
      shortDesc: AppStrings.serviceManicureDesc,
      longDesc: AppStrings.serviceManicureLong,
      icon: Icons.brush,
      imagePath: 'assets/images/services/manikura.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.servicePedicure,
      shortDesc: AppStrings.servicePedicureDesc,
      longDesc: AppStrings.servicePedicureLong,
      icon: Icons.spa,
      imagePath: 'assets/images/services/pedikura.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.serviceWomensHair,
      shortDesc: AppStrings.serviceWomensHairDesc,
      longDesc: AppStrings.serviceWomensHairLong,
      icon: Icons.content_cut,
      imagePath: 'assets/images/services/vlasy.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.serviceMensHair,
      shortDesc: AppStrings.serviceMensHairDesc,
      longDesc: AppStrings.serviceMensHairLong,
      icon: Icons.content_cut,
      imagePath: 'assets/images/services/vlasy2.jpg',
    ),
    _ServiceDetail(
      name: AppStrings.serviceBeauty,
      shortDesc: AppStrings.serviceBeautyDesc,
      longDesc: AppStrings.serviceBeautyLong,
      icon: Icons.star_outline,
      imagePath: 'assets/images/services/style.jpg',
    ),
  ];

  late final List<GlobalKey> _serviceKeys;
  late final List<bool> _hoveredStates;

  @override
  void initState() {
    super.initState();
    _serviceKeys = List.generate(_services.length, (_) => GlobalKey());
    _hoveredStates = List.generate(_services.length, (_) => false);
    if (widget.focusServiceIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToService());
    }
  }

  void _scrollToService([int? indexOverride]) {
    final idx = indexOverride ?? widget.focusServiceIndex;
    if (idx == null || idx < 0 || idx >= _serviceKeys.length) return;
    final ctx = _serviceKeys[idx].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.15,
    );
  }

  Future<void> _openServiceUrl(String serviceName) async {
    String url;
    
    // Map service names to URLs
    switch (serviceName) {
      case 'Manikúra':
      case 'Pedikúra':
      case 'Beauty služby':
        url = 'https://www.notino.sk/salony/identity-studio/';
        break;
      case 'Dámske kaderníctvo':
      case 'Pánske kaderníctvo':
        url = 'https://www.notino.sk/salony/confi-hair/';
        break;
      default:
        return;
    }
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return PageWrapper(
      children: [
        // Page header
        Container(
          color: AppColors.lightBlush,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: const SectionTitle(
            label: AppStrings.servicesSectionLabel,
            title: AppStrings.servicesSectionTitle,
          ),
        ),
        // Image Gallery Section
        if (!isMobile)
          Container(
            color: AppColors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Galéria služieb',
                  style: AppTextStyles.headingMedium.copyWith(
                    fontSize: 28,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _services
                          .asMap()
                          .entries
                          .map((e) => Padding(
                                padding: EdgeInsets.only(
                                  right: e.key == _services.length - 1 ? 0 : 24,
                                ),
                                child: _ServiceImageCard(
                                service: e.value,
                                index: e.key,
                                onHover: (hovering) {
                                  setState(() {
                                    _hoveredStates[e.key] = hovering;
                                  });
                                },
                                isHovered: _hoveredStates[e.key],
                                onTap: _scrollToService,
                              ),
                            ))
                        .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Service detail cards
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: Column(
            children: _services
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    key: _serviceKeys[e.key],
                    padding: const EdgeInsets.only(bottom: 48),
                    child: _ServiceDetailRow(
                      service: e.value,
                      index: e.key,
                      isMobile: isMobile,
                      onServiceTap: _openServiceUrl,
                    ).animate().fadeIn(
                          delay: Duration(milliseconds: 80 * e.key),
                        ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ServiceDetailRow extends StatelessWidget {
  final _ServiceDetail service;
  final int index;
  final bool isMobile;
  final Function(String) onServiceTap;

  const _ServiceDetailRow({
    required this.service,
    required this.index,
    required this.isMobile,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(service.icon, size: 32, color: AppColors.accent),
        const SizedBox(height: 16),
        Text(service.name, style: AppTextStyles.headingMedium),
        const SizedBox(height: 16),
        Text(service.shortDesc, style: AppTextStyles.bodyMuted),
        const SizedBox(height: 12),
        Text(service.longDesc, style: AppTextStyles.bodyLarge),
        const SizedBox(height: 28),
        CustomButton(
          label: AppStrings.bookNow,
          onTap: () => onServiceTap(service.name),
        ),
      ],
    );

    final imageBlock = SizedBox(
      width: isMobile ? 150 : 280,
      height: isMobile ? 200 : 320,
      child: service.imagePath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                service.imagePath!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          : PlaceholderImage(label: '${service.name}\nfotografia (TODO)'),
    );

    if (isMobile) {
      // Mobile: vertical stack
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageBlock,
          const SizedBox(height: 24),
          textBlock
        ],
      );
    }

    // Desktop: alternating horizontal layout
    final reversed = index.isOdd;
    final spacer = const SizedBox(width: 48);
    final expandedTextBlock = Expanded(child: textBlock);
    final children = [expandedTextBlock, spacer, imageBlock];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reversed ? children.reversed.toList() : children,
    );
  }
}

class _ServiceImageCard extends StatefulWidget {
  final _ServiceDetail service;
  final int index;
  final Function(bool) onHover;
  final bool isHovered;
  final Function(int) onTap;

  const _ServiceImageCard({
    required this.service,
    required this.index,
    required this.onHover,
    required this.isHovered,
    required this.onTap,
  });

  @override
  State<_ServiceImageCard> createState() => _ServiceImageCardState();
}

class _ServiceImageCardState extends State<_ServiceImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(_ServiceImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isHovered && !oldWidget.isHovered) {
      _controller.forward();
    } else if (!widget.isHovered && oldWidget.isHovered) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      child: MouseRegion(
        onEnter: (_) => widget.onHover(true),
        onExit: (_) => widget.onHover(false),
        child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.1 + (_controller.value * 0.15),
                    ),
                    blurRadius: 12 + (_controller.value * 8),
                    offset: Offset(0, 4 + (_controller.value * 4)),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image
                    widget.service.imagePath != null
                        ? Image.asset(
                            widget.service.imagePath!,
                            fit: BoxFit.cover,
                          )
                        : PlaceholderImage(
                            label: '${widget.service.name}\nfotografia',
                          ),
                    // Overlay with gradient and text
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(
                              0.3 + (_controller.value * 0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Service name
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Opacity(
                        opacity: 0.6 + (_controller.value * 0.4),
                        child: Text(
                          widget.service.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
).animate(onComplete: (controller) {}).fadeIn(
      delay: Duration(milliseconds: 100 * widget.index),
      duration: const Duration(milliseconds: 600),
    );
  }
}

class _ServiceDetail {
  final String name;
  final String shortDesc;
  final String longDesc;
  final IconData icon;
  final String? imagePath;

  const _ServiceDetail({
    required this.name,
    required this.shortDesc,
    required this.longDesc,
    required this.icon,
    this.imagePath,
  });
}
