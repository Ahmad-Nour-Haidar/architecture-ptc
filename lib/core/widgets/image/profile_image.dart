import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/assets_manager.dart';
import 'base_image.dart';
import 'icon/icon_handler.dart';
class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.url, this.failUrl, this.emptyUrl, this.width, this.height});

  final String? url;
  final String? failUrl;
  final String? emptyUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return BaseImage(
        url:url,
        failUrl:failUrl,
        // emptyWidget: Image.asset(AssetsManager.maleProfileIMG),
        emptyWidget: IconHandler(AssetsManager.logoIMG
          ,width: width,height: height,),
    );
  }
}
