#include "c_plugin.h"
#include <time.h>

// A very short-lived native function.
//
// For very short-lived functions, it is fine to call them on the main isolate.
// They will block the Dart execution while running the native function, so
// only do this for native functions which are guaranteed to be short-lived.
FFI_PLUGIN_EXPORT int sum(int a, int b) { return a + b; }

// A longer-lived native function, which occupies the thread calling it.
//
// Do not call these kind of native functions in the main isolate. They will
// block Dart execution. This will cause dropped frames in Flutter applications.
// Instead, call these native functions on a separate isolate.
FFI_PLUGIN_EXPORT int sum_long_running(int a, int b) {
  // Simulate work.
#if _WIN32
  Sleep(5000);
#else
  usleep(5000 * 1000);
#endif
  return a + b;
}

FFI_PLUGIN_EXPORT void barnsley_fern(int num_points, Point* points) {
    double x = 0;
    double y = 0;

    // Инициализируем генератор случайных чисел, чтобы папоротник был разным при каждом запуске.
    srand((unsigned int)time(NULL));

    for (int i = 0; i < num_points; ++i) {
        double next_x, next_y;
        int r = rand() % 100;

        if (r < 1) {
            // 1. Стебель
            next_x = 0;
            next_y = 0.16 * y;
        } else if (r < 86) { // 1 + 85
            // 2. Последовательно уменьшающиеся листики
            next_x = 0.85 * x + 0.04 * y;
            next_y = -0.04 * x + 0.85 * y + 1.6;
        } else if (r < 93) { // 86 + 7
            // 3. Самый большой левый листик
            next_x = 0.2 * x - 0.26 * y;
            next_y = 0.23 * x + 0.22 * y + 1.6;
        } else { // 93 + 7
            // 4. Самый большой правый листик
            next_x = -0.15 * x + 0.28 * y;
            next_y = 0.26 * x + 0.24 * y + 0.44;
        }

        x = next_x;
        y = next_y;

        points[i].x = x;
        points[i].y = y;
    }
}
