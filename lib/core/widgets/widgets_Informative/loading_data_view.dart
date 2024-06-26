
import 'package:flutter/material.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';

class LoadingDataView extends StatelessWidget {
  final bool isShowContainer;

  const LoadingDataView({super.key, this.isShowContainer = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        // width: ScreenUtil.defaultSize.width * 0.2,
        //   height: ScreenUtil.defaultSize.width * 0.2,
        decoration: BoxDecoration(
            color: isShowContainer ? ColorManager.white : null,
           /// borderRadius: BorderRadius.circular(8.sp //AppSize.s8
            ///     )
        ),
        child:
        const CircularProgressIndicator(
          color: ColorManager.primary,
        )
        // LoadingAnimationWidget.discreteCircle(
        //     secondRingColor: AppColors.secondary,
        //     thirdRingColor: AppColors.lightGray,
        //     color: AppColors.primary,
        //     size: ScreenUtil.defaultSize.width * 0.1)

    );
  }
}

class LoadingDataBaseView extends StatelessWidget {
  final bool isShowContainer;
  const LoadingDataBaseView({super.key, this.isShowContainer = false});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: Alignment.center,
          // width: ScreenUtil.defaultSize.width * 0.2,
          //   height: ScreenUtil.defaultSize.width * 0.2,
          decoration: BoxDecoration(
              color: isShowContainer ? ColorManager.white : null,
              borderRadius: BorderRadius.circular(AppSize.s8)),
          child:
          const CircularProgressIndicator(
            color: ColorManager.primary,

          )
          // LoadingAnimationWidget.discreteCircle(
          //     secondRingColor: ColorManager.primaryLight,
          //     thirdRingColor: ColorManager.grey,
          //     color: ColorManager.primary,
          //     size: ScreenUtil.defaultSize.width * 0.1)

      ),
    );
  }
}
