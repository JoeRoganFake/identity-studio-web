import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Brand logo color — dusty rose #C89FA8
const Color _logoCircleColor = Color(0xFFC89FA8);
// Monogram strokes — lighter tint so they read against the circle
const Color _monoColor = Color(0xFFEDD8DC);

/// The circular "ID" monogram mark.
class LogoMark extends StatelessWidget {
  final double size;
  const LogoMark({super.key, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _LogoMarkPainter()),
    );
  }
}

class _LogoMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double r = size.width / 2;

    // ── Circle fill ──────────────────────────────────────────
    canvas.drawCircle(
      Offset(r, r),
      r,
      Paint()..color = _logoCircleColor,
    );

    // ── Monogram paint setup ─────────────────────────────────
    final paint = Paint()
      ..color = _monoColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.butt;

    // The monogram occupies ~58% of diameter, centred
    final double mW = size.width * 0.58;
    final double mH = size.height * 0.58;
    final double mLeft = (size.width - mW) / 2;
    final double mTop = (size.height - mH) / 2;
    final double mBottom = mTop + mH;

    // "I" — thin vertical bar, left ~28% of monogram width
    final double iX = mLeft + mW * 0.20;
    canvas.drawLine(Offset(iX, mTop), Offset(iX, mBottom), paint);

    // "D" — vertical bar at left edge of D-block + open right arc
    // D occupies right ~65% of monogram
    final double dLeft = mLeft + mW * 0.42;
    canvas.drawLine(Offset(dLeft, mTop), Offset(dLeft, mBottom), paint);

    // Arc: centre is midpoint of the D vertical bar, radius = half mH
    final double arcRadius = mH / 2;
    final double arcCx = dLeft;
    final double arcCy = mTop + mH / 2;
    final Rect arcRect = Rect.fromCircle(
      center: Offset(arcCx, arcCy),
      radius: arcRadius,
    );
    // Draw only right half of circle (−π/2 to +π/2)
    canvas.drawArc(arcRect, -math.pi / 2, math.pi, false, paint);
  }

  @override
  bool shouldRepaint(_LogoMarkPainter old) => false;
}

/// Horizontal logo: circle mark + "Identity studio" + tagline.
/// [dark] — white text for dark backgrounds.
class LogoHorizontal extends StatelessWidget {
  final bool dark;
  final double markSize;
  const LogoHorizontal({super.key, this.dark = false, this.markSize = 40});

  @override
  Widget build(BuildContext context) {
    final Color nameColor = dark ? Colors.white : _logoCircleColor;
    final Color taglineColor =
        dark ? const Color(0xFFBFBFBF) : _logoCircleColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LogoMark(size: markSize),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Identity studio',
              style: GoogleFonts.cormorantGaramond(
                fontSize: markSize * 0.72,
                fontWeight: FontWeight.w300,
                color: nameColor,
                letterSpacing: 0.8,
                height: 1.15,
              ),
            ),
            Text(
              'nails, hair, beauty',
              style: GoogleFonts.lato(
                fontSize: markSize * 0.245,
                fontWeight: FontWeight.w300,
                color: taglineColor,
                letterSpacing: 1.8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Stacked logo: mark on top, text below — for hero / about sections.
class LogoStacked extends StatelessWidget {
  final double markSize;
  const LogoStacked({super.key, this.markSize = 100});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoMark(size: markSize),
        const SizedBox(height: 16),
        Text(
          'Identity studio',
          style: GoogleFonts.cormorantGaramond(
            fontSize: markSize * 0.30,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'nails, hair, beauty',
          style: GoogleFonts.lato(
            fontSize: markSize * 0.14,
            fontWeight: FontWeight.w300,
            color: Colors.white70,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}
