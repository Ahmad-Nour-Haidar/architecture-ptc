import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/operation_file.dart';
import '../../utils/color_manager.dart';
import 'icon/icon_handler.dart';
class BaseImage extends StatelessWidget {
  const BaseImage({super.key, this.url, this.failUrl, this.emptyUrl, this.width, this.height, this.boxFit, this.emptyWidget});

  final String? url;
  final String? failUrl;
  final String? emptyUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Widget? emptyWidget;

  @override
  Widget build(BuildContext context) {
    return  url != null && url!.isNotEmpty
        ? ExtendedImage.network(
      height:height,
        width:width,
      getStorageUrl(url ?? ''),
      fit: boxFit,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Shimmer.fromColors(
                baseColor: ColorManager.primary.withOpacity(0.3),
                highlightColor:
                ColorManager.primary.withOpacity(0.1),
                // enabled: _enabled,
                child: Container(
                  color: Colors.red,
                  width: width,
                  height: height,
                ));
          case LoadState.failed:
            return GestureDetector(
              child:IconHandler(
              failUrl ?? '',//AssetsManager.notFound,
        fit: BoxFit.contain,
        ),
              onTap: () {
               // state.reLoadImage();
              },
            );

          case LoadState.completed:
            // TODO: Handle this case.
        }
        return null;
      },
    )

        :
    emptyWidget??
    SvgPicture.asset(
      emptyUrl ?? '',//AssetsManager.imageDefault,
      fit: BoxFit.fill,
    );
  }
}
