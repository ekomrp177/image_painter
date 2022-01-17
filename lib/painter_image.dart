import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PainterImagePage extends StatefulWidget {
  final List<XFile>? imageFileList;
  const PainterImagePage({
    Key? key,
    required this.imageFileList,
  }) : super(key: key);

  @override
  _PainterImagePageState createState() => _PainterImagePageState();
}

class _PainterImagePageState extends State<PainterImagePage> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File(fullPath);
    imgFile.writeAsBytesSync(image ?? []);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.only(left: 10),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Image Exported successfully.",
                style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () => OpenFile.open(fullPath),
              child: Text(
                "Open",
                style: TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text('Image Painter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: saveImage,
          )
        ],
      ),
      body: ImagePainter.file(
        File(widget.imageFileList![0].path),
        key: _imageKey,
        scalable: true,
        initialStrokeWidth: 2,
        initialColor: Colors.green,
        initialPaintMode: PaintMode.line,
      ),
    );
  }
}
