import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? height, width, imgH, imgW;

  f() async {
    Image image = Image.network('https://i.stack.imgur.com/lkd0a.png');
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
      imgH = info.image.height.toDouble();
      imgW = info.image.width.toDouble();
      height = 0.37253841757774353 * imgH!;
      width = 0.3700019121170044 * imgW!;
      print("$height $width");
      // height = MediaQuery.of(context).size.height * (height! / 1000);
      // width = MediaQuery.of(context).size.width * (width! / 500);
      // print("$height $width");

      setState(() {});
    }));
  }

  // width = BoundingBox.Width (0.284666) * image width (608) = 173
  @override
  Widget build(BuildContext context) {
    f();
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.network('https://i.stack.imgur.com/lkd0a.png'),
            Align(
              alignment:
                  const Alignment(0.31409505009651184, 0.16764284670352936),
              child: Container(
                height: height ?? 10.0,
                width: width ?? 10.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          5,
          (index) =>
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        ),
      ),
    );
  }
}
