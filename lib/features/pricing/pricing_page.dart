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
    _Category(name: 'MANIKÚRA', items: [
      _Item('Hibková - výživný lak', '30 €'),
      _Item('Hibková - farebný lak', '35 €'),
      _Item('Pánska', '30 €'),
      _Item('Gellak jednofarebný', '48 €'),
      _Item('Gellak "francúzska"', '53 €'),
    ]),
    _Category(name: 'GÉLOVÉ NECHTY', items: [
      _Item('Nové "S"', '60 €'),
      _Item('Nové "M"', '65 €'),
      _Item('Nové "L"', '75 €'),
      _Item('Doplnenie "S"', '50 €'),
      _Item('Doplnenie "M"', '55 €'),
      _Item('Doplnenie "L"', '65 €'),
    ]),
    _Category(name: 'PRÍPLATKY', items: [
      _Item('Francúzska', '5 €'),
      _Item('Dizajn / 1 necht', 'od 1 €'),
      _Item('Pigmenty, Babyboomer na všetky nechty', '7 €'),
      _Item('Oprava / 1 necht', '5 €'),
      _Item('Odstránenie', '5 €'),
      _Item('Odstránenie z iného salóna', '10 €'),
    ]),
    _Category(name: 'ESTETICKÁ PEDIKÚRA', items: [
      _Item('Hygienická', '38 €'),
      _Item('Hygienická - lak výživný', '40 €'),
      _Item('Hygienická - lak farebný', '45 €'),
      _Item('Gellak', '50 €'),
      _Item('Gellak francúzska', '55 €'),
      _Item('Odstránenie - lak výživný', '40 €'),
    ]),
    _Category(name: 'BEZ OSETRENIA PLOSKY', items: [
      _Item('Lak farebný', '40 €'),
      _Item('Gellak', '45 €'),
      _Item('Gellak francúzska', '50 €'),
      _Item('Odstránenie - lak výživný', '35 €'),
    ]),
    _Category(name: 'EXTRA POPLATKY', items: [
      _Item('Poplatok za nedodržanie termínu', '20 €'),
      _Item('Modelácia v trvani 3 hod a viac', 'od 5 €'),
    ]),
    _Category(name: 'FARBENIE', items: [
      _Item('Odrasty', '65 €'),
      _Item('Celá dĺžka', '95 €'),
      _Item('Tónovanie', '55 €'),
    ]),
    _Category(name: 'ODFARBOVANIE', items: [
      _Item('Balayage', 'od 165 €'),
      _Item('Odfarbovanie', 'od 150 €'),
    ]),
    _Category(name: 'MELÍR', items: [
      _Item('T zóna', '90 €'),
      _Item('Polovica hlavy', '125 €'),
      _Item('Celá hlava', '155 €'),
    ]),
    _Category(name: 'PRÍPLATKY (VLASY)', items: [
      _Item('Extra čas', '15 €'),
      _Item('Extra materiál', '15 €'),
    ]),
    _Category(name: 'STRIH', items: [
      _Item('Dámsky klasik', '55 €'),
      _Item('Dámsky extra zmena', '70 €'),
      _Item('Pánsky', '25 €'),
      _Item('Strih k službe', '30 €'),
      _Item('Zastrihnutie končekov k službe', '15 €'),
    ]),
    _Category(name: 'ÚPRAVA VLASOV', items: [
      _Item('Fúkaná klasika', '25 €'),
      _Item('Fúkaná vlny', '30 €'),
      _Item('Spoločenský účes', '45 €'),
      _Item('Svadobný účes', '55 €'),
    ]),
    _Category(name: 'STAROSTLIVOSŤ', items: [
      _Item('Rekonštrukčná kúra', '35 €'),
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
              // NAILS SECTION
              Text(
                'STAROSTLIVOSŤ - NECHTY',
                style: AppTextStyles.headingMedium.copyWith(
                  fontSize: 20,
                  color: AppColors.darkText,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ..._categories.asMap().entries
                  .where((e) => [
                    'MANIKÚRA',
                    'GÉLOVÉ NECHTY',
                    'PRÍPLATKY',
                    'ESTETICKÁ PEDIKÚRA',
                    'BEZ OSETRENIA PLOSKY',
                    'EXTRA POPLATKY'
                  ].contains(e.value.name))
                  .map(
                    (e) => _CategorySection(category: e.value)
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 80 * e.key)),
                  ),
              const SizedBox(height: 60),
              // HAIR SECTION
              Text(
                'KADERNÍCTVO',
                style: AppTextStyles.headingMedium.copyWith(
                  fontSize: 20,
                  color: AppColors.darkText,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ..._categories.asMap().entries
                  .where((e) => [
                    'FARBENIE',
                    'ODFARBOVANIE',
                    'MELÍR',
                    'PRÍPLATKY (VLASY)',
                    'STRIH',
                    'ÚPRAVA VLASOV',
                    'STAROSTLIVOSŤ'
                  ].contains(e.value.name))
                  .map(
                    (e) => _CategorySection(category: e.value)
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 80 * e.key)),
                  ),
              const SizedBox(height: 60),
            
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
