import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: double.infinity,
      child: CustomPaint(
        painter: _TopAuthPainter(),
      ),
    );
  }
}

class _TopAuthPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        Rect.fromCircle(center: const Offset(150.0, 50.0), radius: 180);

    // Gradient gradient = const LinearGradient(
    //   begin: Alignment.centerLeft,
    //   end: Alignment.centerRight,
    //   colors: [
    //     Color(0xff149e8e),
    //     Color(0xff36ea7d),
    //   ],
    // );

    final paint = Paint()..shader = AppColors.gradient.createShader(rect);
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * .1, size.height * .8, size.width * .25, size.height * .85);
    path.quadraticBezierTo(
        size.width * .4, size.height * .9, size.width * .5, size.height * .75);
    path.quadraticBezierTo(size.width * .488, size.height * .77,
        size.width * .6, size.height * .6);
    path.quadraticBezierTo(
        size.width * .7, size.height * .5, size.width * .8, size.height * .55);
    path.quadraticBezierTo(
        size.width * .9, size.height * .6, size.width, size.height * .55);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Bottom Login
class BottomAuth extends StatelessWidget {
  const BottomAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.screenHeight,
      width: Dimensions.screenWidth,
      child: CustomPaint(
        painter: _BottomAuthPainter(),
      ),
    );
  }
}

class _BottomAuthPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        Rect.fromCircle(center: const Offset(150.0, 50.0), radius: 180);

    // Gradient gradient = const LinearGradient(
    //   begin: Alignment.centerLeft,
    //   end: Alignment.centerRight,
    //   colors: [
    //     Color(0xff149e8e),
    //     Color(0xff36ea7d),
    //   ],
    // );

    final paint = Paint()..shader = AppColors.gradient.createShader(rect);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * .8);
    path.quadraticBezierTo(size.width * .15, size.height * .7, size.width * .45,
        size.height * .73);
    path.quadraticBezierTo(size.width * .6, size.height * .75, size.width * .65,
        size.height * .65);
    path.quadraticBezierTo(
        size.width * .68, size.height * .6, size.width * .85, size.height * .6);
    path.quadraticBezierTo(
        size.width * .98, size.height * .61, size.width, size.height * .57);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Bottom Register
class BottomRegister extends StatelessWidget {
  const BottomRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: _BottomRegisterPainter(),
      ),
    );
  }
}

class _BottomRegisterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        Rect.fromCircle(center: const Offset(150.0, 50.0), radius: 180);

    // Gradient gradient = const LinearGradient(
    //     begin: Alignment.centerLeft,
    //     end: Alignment.centerRight,
    //     colors: [Color(0xff149e8e), Color(0xff36ea7d)]);

    final paint = Paint()..shader = AppColors.gradient.createShader(rect);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * .85);
    path.quadraticBezierTo(size.width * .28, size.height * .98,
        size.width * .48, size.height * .85);
    path.quadraticBezierTo(
        size.width * .9, size.height * .5, size.width, size.height * .5);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
