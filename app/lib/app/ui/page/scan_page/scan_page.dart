import 'package:app/app/res/r.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();

  late Animation<double> _animation;
  late AnimationController _controller;

  final Tween<double> _rotationTween = Tween(begin: 0.05, end: 0.95);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = _rotationTween.animate(_controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            MobileScanner(
                allowDuplicates: false,
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                  } else {
                    final String code = barcode.rawValue!;
                    debugPrint('Barcode found! $code');
                  }
                }),
            CustomPaint(
              painter: _ScanFramePainter(
                lineMoveValue: _animation.value,
              ),
              child: Container(),
            ),
            Positioned(
              left: 34,
              top: 56,
              child: GestureDetector(
                child: Image.asset(
                  R.assetsImagesArrowLeft,
                  width: 28,
                  height: 28,
                  color: Colors.white,
                ),
                onTap: () => Get.back(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  final Size frameSize = const Size.square(260.0);
  final double cornerLength = 20.0;

  final double lineMoveValue;

  _ScanFramePainter({required this.lineMoveValue});

  @override
  void paint(Canvas canvas, Size size) {
    double leftTopX = (size.width - frameSize.width) / 2;
    double leftTopY = (size.height - frameSize.height) / 2;
    var rect =
        Rect.fromLTWH(leftTopX, leftTopY, frameSize.width, frameSize.height);
    Offset leftTop = rect.topLeft;
    Offset leftBottom = rect.bottomLeft;
    Offset rightTop = rect.topRight;
    Offset rightBottom = rect.bottomRight;

    Paint paint = Paint()
      ..color = const Color(0xFF9EA2FF)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square // 解决因为线宽导致交界处不是直角的问题
      ..style = PaintingStyle.stroke;

    Offset horizontalOffset = Offset(cornerLength, 0);
    Offset verticalOffset = Offset(0, cornerLength);

    // 左上角
    canvas.drawLine(leftTop, leftTop + horizontalOffset, paint);
    canvas.drawLine(leftTop, leftTop + verticalOffset, paint);
    // 左下角
    canvas.drawLine(leftBottom, leftBottom + horizontalOffset, paint);
    canvas.drawLine(leftBottom, leftBottom - verticalOffset, paint);
    // 右上角
    canvas.drawLine(rightTop, rightTop - horizontalOffset, paint);
    canvas.drawLine(rightTop, rightTop + verticalOffset, paint);
    // 右下角
    canvas.drawLine(rightBottom, rightBottom - horizontalOffset, paint);
    canvas.drawLine(rightBottom, rightBottom - verticalOffset, paint);

    paint.strokeWidth = 2;
    var lineY = leftTopY + frameSize.height * lineMoveValue;
    canvas.drawLine(
      Offset(leftTopX + 20.0, lineY),
      Offset(rightTop.dx - 20.0, lineY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
