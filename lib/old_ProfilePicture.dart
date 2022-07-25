import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:http/http.dart' as http;

class ImageLoader extends StatelessWidget {
  const ImageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Loading state"),
        ),
      ),
      body: const ListTileShimmer(onlyShowProfilePicture: true),
    );
  }
}

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePage();
}

class _ImagePage extends State<ImagePage> {
  Image image = Image.network("");
  bool loading = true;

  @override
  void initState() {
    super.initState();

    Future.sync(loadImage);
  }

  Future loadImage() async {
    Uri url =
        Uri.https('thispersondoesnotexist.com', '/image', {'q': '{https}'});
    var response = await http.get(url);

    image = Image.memory(response.bodyBytes);

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("PUT NAME HERE"),
        ),
      ),
      body: loading ? const ImageLoader() : image,
    );
  }
}
