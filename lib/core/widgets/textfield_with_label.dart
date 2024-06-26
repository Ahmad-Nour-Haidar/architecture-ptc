import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/values_manager.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({
    super.key,
    required this.label,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.textColor = ColorManager.white,
  });

  final String label;
  final Widget child;
  final EdgeInsets? padding;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          child
        ],
      ),
    );
  }
}
