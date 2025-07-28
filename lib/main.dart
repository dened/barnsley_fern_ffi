import 'package:barnsley_fern_ffi/barnsley_fern_generator.dart' as barnsley;
import 'package:barnsley_fern_ffi/fern_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: Scaffold(
      body: Padding(padding: EdgeInsets.all(16), child: BarnsleyFern()),
    ),
  );
}

/// {@template main}
/// BarnsleyFern widget.
/// {@endtemplate}
class BarnsleyFern extends StatefulWidget {
  /// {@macro main}
  const BarnsleyFern({
    super.key, // ignore: unused_element
  });

  @override
  State<BarnsleyFern> createState() => _BarnsleyFernState();
}

/// State for widget BarnsleyFern.
class _BarnsleyFernState extends State<BarnsleyFern> {
  int _pointCounts = 100000;
  late TextEditingController _controller;
  late List<Offset> _points;
  Method _currentValue = Method.dart;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '$_pointCounts');
    _updatePoints();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _methodChanged(Method? method) {
    if (method == null) {
      return;
    }
    
    setState(() {
      _currentValue = method;
      _updatePoints();
    });
  }

  void _updatePoints() {
    switch (_currentValue) {
      case Method.dart:
        _points = barnsley.generate(_pointCounts);
      case Method.ffi:
        _points = barnsley.generateFFI(_pointCounts);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: Column(
      children: [
        const CircularProgressIndicator.adaptive(),
        RadioListTile(
          title: const Text('ffi'),
          value: Method.ffi,
          groupValue: _currentValue,
          onChanged: _methodChanged,
        ),
        RadioListTile(
          title: const Text('dart'),
          value: Method.dart,
          groupValue: _currentValue,
          onChanged: _methodChanged,
        ),
        TextField(
          controller: _controller,
          onEditingComplete: () {
            setState(() {
              _pointCounts = int.parse(_controller.text);
              _updatePoints();
            });
          },
        ),
        Expanded(
          child: RepaintBoundary(child: FernWidget(points: _points)),
        ),
      ],
    ),
  );
}

enum Method { dart, ffi }
