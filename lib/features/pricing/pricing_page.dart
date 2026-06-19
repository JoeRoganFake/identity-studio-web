import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/common/section_title.dart';
import '../../../core/widgets/common/page_wrapper.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  // TODO: Update all prices with real values confirmed by the salon
  static const List<_Category> _categories = [
    _Category(name: 'Manikúra', items: [
      _Item('Klasická manikúra', '15 €'),
      _Item('Gél / Shellac', '25 €'),
      _Item('Nail art – jednoduchý', '5 €'),
      _Item('Nail art – zložitý', '10 €+'),
      _Item('Predĺženie nechtov', '40 €+'),
      _Item('Odstránenie gélu', '10 €'),
    ]),
    _Category(name: 'Pedikúra', items: [
      _Item('Klasická pedikúra', '20 €'),
      _Item('Medicínska pedikúra', '30 €'),
      _Item('Gélová pedikúra', '30 €'),
      _Item('Relaxačný zábal', '15 €'),
    ]),
    _Category(name: 'Dámske kaderníctvo', items: [
      _Item('Strih + fúkanie', '25 €+'),
      _Item('Farbenie celé', '45 €+'),
      _Item('Melírovanie / Balayage', '60 €+'),
      _Item('Keratin', '80 €+'),
      _Item('Regeneračné ošetrenie', '20 €+'),
      _Item('Spoločenský účes', '35 €+'),
    ]),
    _Category(name: 'Pánske kaderníctvo', items: [
      _Item('Strih', '12 €'),
      _Item('Strih + úprava brady', '18 €'),
      _Item('Úprava brady / fúzov', '10 €'),
      _Item('Farbenie', '20 €+'),
    ]),
    _Category(name: 'Beauty služby', items: [
      _Item('Čistenie pleti', '35 €'),
      _Item('Úprava obočia', '8 €'),
      _Item('Farbenie obočia a rias', '12 €'),
      _Item('Laminovanie rias', '40 €'),
      _Item('Laminovanie obočia', '35 €'),
      _Item('Permanentný make-up', '120 €+'),
    ]),
  ];

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
            label: AppStrings.pricingSectionLabel,
            title: AppStrings.pricingSectionTitle,
          ),
        ),
        // Price list
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 80,
            vertical: 80,
          ),
          child: Column(
            children: [
              ..._categories.asMap().entries.map(
                    (e) => _CategorySection(category: e.value)
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 80 * e.key)),
                  ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightBlush,
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  AppStrings.pricingNote,
                  style: AppTextStyles.bodyMuted.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  final _Category category;

  const _CategorySection({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.name, style: AppTextStyles.headingMedium),
          const SizedBox(height: 8),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 8),
          ...category.items.map((item) => _PriceRow(item: item)),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final _Item item;

  const _PriceRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Expanded(child: Text(item.name, style: AppTextStyles.bodyLarge)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: LayoutBuilder(
                builder: (_, constraints) => CustomPaint(
                  size: Size(constraints.maxWidth, 1),
                  painter: _DottedLinePainter(),
                ),
              ),
            ),
          ),
          Text(item.price, style: AppTextStyles.price),
        ],
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) => false;
}

class _Category {
  final String name;
  final List<_Item> items;

  const _Category({required this.name, required this.items});
}

class _Item {
  final String name;
  final String price;

  const _Item(this.name, this.price);
}
