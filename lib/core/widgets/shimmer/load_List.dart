import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/values_manager.dart';
import '../../utils/color_manager.dart';
import 'load_base.dart';

class LoadList extends StatelessWidget {
  const LoadList({super.key, this.itemCount=3});
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return
     Column(
      children:

      [
        for(int i=0;i<(itemCount??0);i++)
        content(context),

      ],
    );
  }

  content(BuildContext context) {
    return LoadBase(

      child:
        Container(

        padding: const EdgeInsets.all(AppPadding.p12),
            height:ScreenUtil.defaultSize.width /3,
    margin: const EdgeInsets.symmetric(
    vertical: AppMargin.m8, horizontal: AppMargin.m8),
    decoration: BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: ColorManager.black.withOpacity(.1),
    blurRadius: 8.0,
    ),
    ])
    ));
  }
}
