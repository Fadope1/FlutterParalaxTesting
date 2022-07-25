import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class ScrollableMainPage extends StatelessWidget {
  const ScrollableMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SvgPicture.asset("images/bg.svg"));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double rateZero = 0;
  double rateOne = 0;
  double rateTwo = 0;

  String asset = "";
  double top = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            //only if scroll update notification is triggered
            setState(() {
              rateTwo -= v.scrollDelta! / 1;
              rateOne -= v.scrollDelta! / 2;
              rateZero -= v.scrollDelta! / 2.5;
            });
            return true;
          }
          return false;
        },
        child: Stack(
          children: <Widget>[
            ParallaxWidget(top: rateZero, asset: "bg"),
            ParallaxWidget(top: rateOne, asset: "middle"),
            ParallaxWidget(top: rateTwo, asset: "front"),
            ListView(
              children: <Widget>[
                Container(
                  height: 750,
                  color: Colors.transparent,
                  child: const Center(
                    widthFactor: 2,
                    child: Text(
                      "This is a test",
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: "MontSerrat-ExtraLight",
                          letterSpacing: 2,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromRGBO(255, 215, 0, 1),
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Fabian ist",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "MontSerrat-ExtraLight",
                            letterSpacing: 1.8,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      Text(
                        "der Beste",
                        style: TextStyle(
                            fontSize: 51,
                            fontFamily: "MontSerrat-Regular",
                            letterSpacing: 1.8,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 190,
                        child: Divider(
                          height: 1,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "really",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat-Extralight",
                          letterSpacing: 1.3,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        "nice",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Montserrat-Regular",
                          letterSpacing: 1.8,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    super.key,
    required this.top,
    required this.asset,
  });

  final double top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Container(
        height: 1500,
        child: SvgPicture.asset("images/$asset.svg", fit: BoxFit.fitWidth),
      ),
    );
  }
}
