
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';
class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.item,
  });

  final String item;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
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
          ]),
      child: IntrinsicHeight(
        child: SizedBox(
            width: ScreenUtil.defaultSize.width /2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Text(
                item ,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
      ),
    );
  }
}
