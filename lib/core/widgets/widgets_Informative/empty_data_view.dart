import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';

class EmptyDataView extends StatelessWidget {
  EmptyDataView({super.key, this.pathImage,this.text, this.height});
  String? pathImage;
  String? text;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        true
            ? SvgPicture.asset(
                pathImage ?? AssetsManager.notFound,
                width: ScreenUtil.defaultSize.width / 2,
                height: height ?? ScreenUtil.defaultSize.width / 2,
              )
            : Icon(
                Icons.warning_amber_outlined,
                size: ScreenUtil.defaultSize.width / 3,
                color: ColorManager.grey,
              ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Text(
          text??'No Data Yet!',
          // tr(text??'No Data Yet!'),
          style: TextStyle(
            fontSize: ScreenUtil.defaultSize.width / 16,
            color: Colors.grey,
          ),
        )
      ],
    ));
  }
}
