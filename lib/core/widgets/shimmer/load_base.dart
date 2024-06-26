import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/color_manager.dart';

class LoadBase extends StatelessWidget {
  const LoadBase({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      // baseColor: Theme.of(context).primaryColor.withOpacity(.20)!,
      // highlightColor: Theme.of(context).primaryColor.withOpacity(.10),

      baseColor: ColorManager.grey.withOpacity(.90),
      highlightColor:  ColorManager.grey.withOpacity(.30),
      // enabled: _enabled,
      child: child??const SizedBox.shrink(),
    );
  }


}
