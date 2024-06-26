import 'package:flutter/cupertino.dart';


import '../helper/sizer_media_query.dart';
import '../utils/assets_manager.dart';

class ContainerWithImage extends StatelessWidget {
  const ContainerWithImage(
      {super.key,
      this.imagePath = AssetsManager.logoIMG,
      this.child,
      this.alignment = Alignment.center});

  final String imagePath;
  final Widget? child;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment!,
      children: [
        Image.asset(
          imagePath,
          width: getWidth(context),
          height: getHeight(context),
          fit: BoxFit.cover,
        ),
        child!
      ],
    );
  }
}
