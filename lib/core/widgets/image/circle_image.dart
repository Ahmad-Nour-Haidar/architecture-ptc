import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_image.dart';
class CircleImage extends StatelessWidget {
  const CircleImage({super.key, this.url, this.failUrl, this.emptyUrl, this.width, this.height});

  final String? url;
  final String? failUrl;
  final String? emptyUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {

    return ClipOval(child:

    BaseImage(
      url:url,
      boxFit: BoxFit.fill,
      height: 1000,
    )
      ,);
  }
}
