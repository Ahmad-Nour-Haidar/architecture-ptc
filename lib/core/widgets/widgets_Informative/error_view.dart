import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/error_handler/network_exceptions.dart';
import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';

class ErrorView extends StatelessWidget {
  ErrorView({super.key, this.networkExceptions, this.pathImage});
  final NetworkExceptions? networkExceptions;
  String? pathImage;
  @override
  Widget build(BuildContext context) {
    Widget errorView = ErrorViewBase(
      value: "Error!",
      assetSvg: pathImage,
    );

    if (networkExceptions != null) {
      networkExceptions!.when(
        notImplemented: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        requestCancelled: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        loggingInRequired: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        internalServerError: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        notFound: (String reason) {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        serviceUnavailable: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        methodNotAllowed: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        badRequest: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        unauthorizedRequest: (String error) {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        unprocessableEntity: (String error) {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        unexpectedError: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        requestTimeout: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        noInternetConnection: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
            icon: Icons.wifi_off_outlined,
          );
        },
        conflict: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        sendTimeout: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        unableToProcess: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        defaultError: (String error) {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        formatException: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
        notAcceptable: () {
          errorView = ErrorViewBase(
            value: NetworkExceptions.getErrorMessage(networkExceptions!),
          );
        },
      );
    }
    return errorView;
  }
}

class ErrorViewBase extends StatelessWidget {
  const ErrorViewBase({super.key, this.value, this.icon, this.assetSvg});

  //final NetworkExceptions? networkExceptions;
  final String? value;
  final IconData? icon;
  final String? assetSvg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      assetSvg == null
          ? SvgPicture.asset(
          assetSvg ?? AssetsManager.notFound,
          width: ScreenUtil.defaultSize.width / 2,
          height: ScreenUtil.defaultSize.width / 2,
            )
          : Icon(
              icon ?? Icons.report,
              size: ScreenUtil.defaultSize.width / 3,
              color: ColorManager.grey,
            ),
      const SizedBox(
        height: AppSize.s10,
      ),
      Text(
        value ?? '',
        style: TextStyle(
          fontSize: ScreenUtil.defaultSize.width / 16,
          color: Colors.grey,
        ),
      )
    ],
      ),
    );
  }
}

// class ErrorViewSlideBar extends StatelessWidget {
//   ErrorViewSlideBar({this.value, this.icon, this.assetSvg});
//
//   //final NetworkExceptions? networkExceptions;
//   final String? value;
//   final IconData? icon;
//   final String? assetSvg;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         assetSvg == null
//             ? Center(
//                 child: SvgPicture.asset(
//                   assetSvg ?? InfoAssets.not_found_second,
//                 ),
//               )
//             : Icon(
//                 icon ?? Icons.report,
//                 size: ScreenUtil.defaultSize.width / 3,
//                 color: AppColors.lightGray,
//               ),
//         SizedBox(
//           height: 10.h,
//         ),
//         Text(
//           value ?? '',
//           style: TextStyle(
//             fontSize: ScreenUtil.defaultSize.width / 16,
//             color: Colors.grey,
//           ),
//         )
//       ],
//     );
//   }
// }
