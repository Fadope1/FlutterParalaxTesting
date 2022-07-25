import 'package:flutter/material.dart';
import 'package:flutter_application_1/world_paralax.dart';
import 'package:flutter_svg/svg.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<StatefulWidget> createState() => _FrontPage();
}

class _FrontPage extends State<FrontPage> {
  static const List<String> assets = <String>[
    "images/bg.svg",
    "images/middle.svg",
    "images/front.svg",
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
      body: NotificationListener(
        onNotification: ((notification) {
          if (notification is ScrollUpdateNotification) {
            double factor = 1.0;
            for (String asset in assets) {
              setState(() {
                _positions[asset] = _positions[asset]! -
                    notification.scrollDelta! / factor; // not working
              });
              factor += _factor;
            }
            return true;
          }

          return false;
        }),
        child: Stack(
          children: paralaxWidgetBuilder() +
              <Widget>[
                ListView(
                  children: <Widget>[
                    const SizedBox(height: 150),
                    const Text(
                      "Example Greetings title here",
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 290),
                    Container(
                      height: 500,
                      color: const Color.fromRGBO(255, 215, 0, 1),
                      child: Column(
                          children: const <Widget>[
                                SizedBox(height: 185),
                                Text("Example subtitle here"),
                                Divider(),
                                Text("Made by Fabian"),
                              ] +
                              [
                                TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SecondPage(),
                                    ),
                                  ),
                                  child: const Text("Next Screen"),
                                )
                              ]),
                    ),
                  ],
                ),
              ],
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
    print(top);

    return Positioned(
      top: top,
      left: leftShift ?? 0,
      child: SvgPicture.asset(asset, fit: BoxFit.cover),
    );
  }
}
