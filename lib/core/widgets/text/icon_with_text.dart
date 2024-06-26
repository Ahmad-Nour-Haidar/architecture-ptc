import 'package:flutter/cupertino.dart';

import '../../utils/values_manager.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.text,
     this.icon,
    this.iconSize = 14.0,
    this.textColor,
    this.fontSize=10,
    this.iconColor,

  });

  final IconData? icon;
  final String text;
  final double iconSize;
  final double? fontSize;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(icon!=null)
        Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        const SizedBox(
          width: AppSize.s1_5,
        ),
        Flexible(
          child: Text(
            text,

            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

