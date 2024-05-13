// ignore_for_file: camel_case_types

import 'package:my_eco_print/core/app_export.dart';

class paint extends StatelessWidget {
  final TextDirection textDirection;
  final String additionalText;

  const paint({
    Key? key,
    required this.textDirection,
    required this.additionalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 47.v,
        width: 40.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: textDirection == TextDirection.rtl
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: SizedBox(
                height: 47,
                width: 40,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 50.v,
                    ),
                    child: CustomPaint(
                      painter: MyPainter(textDirection: textDirection),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 2.h),
                            child: Text(
                              additionalText,
                              style: CustomTextStyles.titleMediumWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final TextDirection textDirection;

  MyPainter({required this.textDirection});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xff99CA3C);
    path = Path();

    if (textDirection == TextDirection.ltr) {
      // English text direction, align the shape to the left
      path.lineTo(size.width * 0.78, 0);
      path.cubicTo(
          size.width * 0.78, 0, size.width * 0.22, 0, size.width * 0.22, 0);
      path.cubicTo(
          size.width * 0.1, 0, 0, size.height * 0.09, 0, size.height * 0.19);
      path.cubicTo(
          0, size.height * 0.19, 0, size.height * 0.9, 0, size.height * 0.9);
      path.cubicTo(0, size.height, size.width * 0.07, size.height * 1.03,
          size.width * 0.16, size.height * 0.98);
      path.cubicTo(size.width * 0.16, size.height * 0.98, size.width * 0.45,
          size.height * 0.85, size.width * 0.45, size.height * 0.85);
      path.cubicTo(size.width * 0.48, size.height * 0.83, size.width * 0.52,
          size.height * 0.83, size.width * 0.55, size.height * 0.85);
      path.cubicTo(size.width * 0.55, size.height * 0.85, size.width * 0.83,
          size.height * 0.98, size.width * 0.83, size.height * 0.98);
      path.cubicTo(size.width * 0.93, size.height * 1.03, size.width,
          size.height, size.width, size.height * 0.9);
      path.cubicTo(size.width, size.height * 0.9, size.width,
          size.height * 0.19, size.width, size.height * 0.19);
      path.cubicTo(size.width, size.height * 0.09, size.width * 0.9, 0,
          size.width * 0.78, 0);
    } else {
      path.lineTo(size.width * 0.22, 0);
      path.cubicTo(
          size.width * 0.22, 0, size.width * 0.78, 0, size.width * 0.78, 0);
      path.cubicTo(size.width * 0.83, 0, size.width, size.height * 0.09,
          size.width, size.height * 0.19);
      path.cubicTo(size.width, size.height * 0.19, size.width,
          size.height * 0.9, size.width, size.height * 0.9);
      path.cubicTo(size.width, size.height, size.width * 0.93,
          size.height * 1.03, size.width * 0.83, size.height * 0.98);
      path.cubicTo(size.width * 0.83, size.height * 0.98, size.width * 0.55,
          size.height * 0.85, size.width * 0.55, size.height * 0.85);
      path.cubicTo(size.width * 0.52, size.height * 0.83, size.width * 0.48,
          size.height * 0.83, size.width * 0.45, size.height * 0.85);
      path.cubicTo(size.width * 0.45, size.height * 0.85, size.width * 0.16,
          size.height * 0.98, size.width * 0.16, size.height * 0.98);
      path.cubicTo(size.width * 0.07, size.height * 1.03, 0, size.height, 0,
          size.height * 0.9);
      path.cubicTo(
          0, size.height * 0.9, 0, size.height * 0.19, 0, size.height * 0.19);
      path.cubicTo(
          0, size.height * 0.09, size.width * 0.1, 0, size.width * 0.22, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
