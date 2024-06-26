import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';


class ImageLocalHandler extends StatelessWidget {
  const ImageLocalHandler( this.url,{super.key,this.width, this.height, this.fit,this.color});
  final String? url;
  final double? width, height;
  final  BoxFit? fit;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return  getImageWidget();
  }
  Widget getImageWidget() {
   String  imagePath=url??'';
    if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(imagePath,width: width,height: height,fit:fit??BoxFit.contain,
          colorFilter: color==null?null:ColorFilter.mode(color!, BlendMode.srcIn));
    } else if (imagePath.endsWith('.png') || imagePath.endsWith('.jpg') || imagePath.endsWith('.jpeg')) {
      return Image.asset(imagePath,width: width,height: height,fit:fit,color: color,);
    } else if (imagePath.endsWith('.gif')) {
      return Image.asset(imagePath,width: width,height: height,fit:fit,color: color);
    } else if (imagePath.endsWith('.webp')) {
      return Image.asset(imagePath,width: width,height: height,fit:fit,color: color);
    } else if (imagePath.endsWith('.bmp')) {
      return Image.asset(imagePath,width: width,height: height,fit:fit,color: color);
    } else if (imagePath.endsWith('.tiff') || imagePath.endsWith('.tif')) {
      return Image.asset(imagePath,width: width,height: height,fit:fit,color: color);
    } else if (imagePath.endsWith('.ico')) {
      return Image.asset(imagePath,width: width,height: height,fit:fit,color: color);
    } else {
      return const Text('Unsupported image format');
    }
  }
}
