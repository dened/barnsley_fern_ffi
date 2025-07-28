import 'dart:math';
import 'dart:ui';

import 'package:c_plugin/c_plugin.dart';

List<Offset> generate(int n) {
  final rnd = Random();
  double x = 0, y = 0;
  final points = <Offset>[];

  for (var i = 0; i < n; i++) {
    double nextX, nextY;
    final r = rnd.nextDouble();

    if (r < 0.01) {
      nextX = 0;
      nextY = 0.16 * y;
    } else if (r < 0.86) {
      nextX = 0.85 * x + 0.04 * y;
      nextY = -0.04 * x + 0.85 * y + 1.6;
    } else if (r < 0.93) {
      nextX = 0.2 * x - 0.26 * y;
      nextY = 0.23 * x + 0.22 * y + 1.6;
    } else {
      nextX = -0.15 * x + 0.28 * y;
      nextY = 0.26 * x + 0.24 * y + 0.44;
    }

    x = nextX;
    y = nextY;
    points.add(Offset(x, y));
  }

  return points;
}

List<Offset> generateFFI(int n) => barnsleyFern(n);
