// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<StatefulWidget> createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  static const List<String> assets = <String>[
    "images/planet_bg.svg",
    "images/planet.svg",
  ];

  final Map<String, double> _positions = {};
  final double startPosition = 0.0;
  final double leftShift = -250.0;
  final double _factor = .4;

  @override
  initState() {
    super.initState();

    // init svg images and position
    for (String asset in assets) {
      _positions[asset] = startPosition;
    }
  }

  List<Widget> paralaxWidgetBuilder() {
    final List<Widget> widgets = <Widget>[];

    for (String asset in assets) {
      widgets.add(
        ParalaxWidget(
            asset: asset, top: _positions[asset]!, leftShift: leftShift),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(),
      body: Listener(
        onPointerHover: (details) => print(details.position),
        child: const Center(
          child: Text(
            "nice",
            textScaleFactor: 15,
          ),
        ),
      ),
    );
  }
}

class ParalaxWidget extends StatelessWidget {
  const ParalaxWidget(
      {super.key, required this.asset, required this.top, this.leftShift});

  final String asset;
  final double top;
  final double? leftShift;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: leftShift ?? 0,
      child: Image.asset(
        asset,
        fit: BoxFit.fitHeight,
        scale: 5,
        height: 1500,
      ),
    );
  }
}
