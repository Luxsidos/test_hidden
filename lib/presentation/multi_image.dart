import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:image_pickers/image_pickers.dart';
import 'dart:ui' as ui;

class MultiImagePage extends StatefulWidget {
  const MultiImagePage({Key? key}) : super(key: key);

  @override
  State<MultiImagePage> createState() => _MultiImagePageState();
}

class _MultiImagePageState extends State<MultiImagePage> {
  GalleryMode _galleryMode = GalleryMode.image;
  GlobalKey? globalKey;
  @override
  void initState() {
    super.initState();
    globalKey = GlobalKey();
  }

  List<Media> _listImagePaths = [];
  String? dataImagePath = "";

  Future<void> selectImages() async {
    try {
      _galleryMode = GalleryMode.image;
      _listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: _galleryMode,
        showGif: true,
        selectCount: 2,
        showCamera: true,
        cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Colors.blue),
      );
      debugPrint("${_listImagePaths.length}");
      if (_listImagePaths.isNotEmpty) {
        for (var media in _listImagePaths) {
          debugPrint(media.path.toString());
        }
      }
      setState(() {});
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Multiple image selection'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _listImagePaths.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          ImagePickers.previewImagesByMedia(
                            _listImagePaths,
                            index,
                          );
                        },
                        child: Image.file(
                          File(
                            _listImagePaths[index].path!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                ElevatedButton(
                  onPressed: () {
                    selectImages();
                  },
                  child: const Text("Select Image"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
