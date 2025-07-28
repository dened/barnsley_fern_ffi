import 'dart:ui';

import 'package:flutter/material.dart';

class FernWidget extends LeafRenderObjectWidget {
  const FernWidget({required this.points, super.key});

  final List<Offset> points;

  @override
  RenderObject createRenderObject(BuildContext context) => _FernRenderObject(points);

  @override
  void updateRenderObject(BuildContext context, covariant _FernRenderObject renderObject) {
    renderObject.points = points;
  }
}

class _FernRenderObject extends RenderBox {
  _FernRenderObject(List<Offset> points) : _points = points;

  List<Offset> _points;
  List<Offset> get points => _points;
  set points(List<Offset> value) {
    _points = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    final biggestSize = constraints.biggest;
    const aspectRatio = 1 / 2;
    if (biggestSize.width / biggestSize.height > aspectRatio) {
      size = Size(biggestSize.height * aspectRatio, biggestSize.height);
    } else {
      size = Size(biggestSize.width, biggestSize.width / aspectRatio);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 0.5;
    final scale = size.height / 11.0;
    final offset = Offset(size.width / 2, size.height);

    context.canvas.drawPoints(
      PointMode.points,
      points.map((p) => Offset(p.dx * scale, -p.dy * scale) + offset).toList(),
      paint,
    );
  }
}
