import 'package:flutter/cupertino.dart';

import '../image_local_handler.dart';

class IconHandler extends StatelessWidget {
  const IconHandler( this.icon,{super.key, this.width, this.height, this.fit, this.color, this.size});
  final dynamic icon;
  final double? width, height,size;

  final  BoxFit? fit;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return  displayIconOrImage();
  }
   Widget displayIconOrImage() {
    switch (icon.runtimeType) {
      case IconData:
        return Icon(icon,size: size??width,color:color);
      case String:
        return ImageLocalHandler(icon,width: width??size,height: height??size,fit: fit,color:color);
      default:
        return const Text('Unsupported type');
    }
  }
}
