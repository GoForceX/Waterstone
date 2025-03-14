import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waterstone/main.dart';

class RefreshableImage extends StatefulWidget {
  const RefreshableImage({
    super.key,
    required this.src,
    required this.width,
    required this.height,
  });

  final String src;
  final double width;
  final double height;

  @override
  State<RefreshableImage> createState() => _RefreshableImageState();
}

class _RefreshableImageState extends State<RefreshableImage> {
  late Widget _pic;
  Dio dio = BaseSingleton.singleton.dio;

  @override
  void initState() {
    _pic = SizedBox(
      width: widget.width,
      height: widget.height,
      child: Center(child: CircularProgressIndicator()),
    );
    _updateImgWidget();
    super.initState();
  }

  _updateImgWidget() async {
    setState(() {
      _pic = SizedBox(
        width: widget.width,
        height: widget.height,
        child: Center(child: CircularProgressIndicator()),
      );
    });
    Response resp = await dio.get(
      widget.src,
      options: Options(responseType: ResponseType.bytes),
    );
    List<int> data = resp.data as List<int>;
    Uint8List bytes = Uint8List.fromList(data);
    setState(() {
      _pic = Image.memory(bytes, width: widget.width, height: widget.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _updateImgWidget();
      },
      child: _pic,
    );
  }
}
