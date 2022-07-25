import 'package:flutter/material.dart';

import 'front_page.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Paralex test app",
        home: FrontPage(),
        debugShowCheckedModeBanner: false);
  }
}
