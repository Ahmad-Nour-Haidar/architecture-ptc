import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/values_manager.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({
    super.key,
    this.onPressed,
    this.text = '',
    this.backgroundColor = ColorManager.secondary,
    this.textColor = ColorManager.black,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          minimumSize: const Size(double.infinity, AppSize.s50),
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(
            color: textColor,
          ),
        ));
  }
}
