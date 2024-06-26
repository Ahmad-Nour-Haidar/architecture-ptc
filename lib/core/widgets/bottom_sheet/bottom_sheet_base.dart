
import 'package:flutter/material.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';


Future<dynamic> bottomSheetBase(
    { required BuildContext context,
      required String title,
      required Widget content,
      Widget? action,
      Widget? divider}) {
  return showModalBottomSheet(
      context: context,
    backgroundColor: ColorManager.white,
    isScrollControlled: true,
    // isDismissible: false,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),


      builder: (BuildContext context) =>
          Container(
            decoration: const BoxDecoration(
                color: ColorManager.white,
                borderRadius:
                BorderRadius.vertical(
                    top: Radius.circular(
                        24))),
            child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Container(
                  clipBehavior:
                  Clip.antiAlias,
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal:
                      AppPadding.p12,
                      vertical:
                      AppPadding.p12),
                  decoration: const BoxDecoration(
                      color: ColorManager
                          .appBarColor,
                      borderRadius:
                      BorderRadius.vertical(
                          top: Radius
                              .circular(
                              24))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      // onTap: () =>  goRouter.pop(),
                      child: const Icon(Icons.close,
                      color: ColorManager.primary,
                      ),
                    ),

                      Text(
                        title,
                        textAlign:
                        TextAlign.center,
                        style: const TextStyle(
                            color: ColorManager
                                .primary,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 18),
                      ),

                    action ?? const SizedBox.shrink()
                      ,
                    ],
                  ),
                ),
                    Padding(padding:  const EdgeInsets
                        .symmetric(
                    horizontal:
                    AppPadding.p12,
                        vertical:
                        AppPadding.p10),
                    child: content,
                    )
                  ])))
           );
}
