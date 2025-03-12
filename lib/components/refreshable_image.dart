import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefreshableImage extends StatefulWidget {
  const RefreshableImage({super.key, required this.src, required this.width, required this.height});

  final String src;
  final double width;
  final double height;

  @override
  State<RefreshableImage> createState() => _RefreshableImageState();
}

class _RefreshableImageState extends State<RefreshableImage> {
  late Widget _pic;

  @override
  void initState() {
    _pic = Image.network(widget.src, width: widget.width, height: widget.height,);
    super.initState();
  }

  _updateImgWidget() async {
    setState(() {
      _pic = CircularProgressIndicator();
    });
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(widget.src)).load(widget.src))
        .buffer
        .asUint8List();
    setState(() {
      _pic = Image.memory(bytes, width: widget.width, height: widget.height,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _updateImgWidget();
        },
        child: _pic
    );
  }
}