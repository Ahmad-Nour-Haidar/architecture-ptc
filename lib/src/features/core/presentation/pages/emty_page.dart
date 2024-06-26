import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
              'Empty',
              style: TextStyle(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
          ),
    );

    //   Scaffold(
    //     appBar: AppBar(
    //
    //     title: const Text(
    //     'Empty',
    //     style: TextStyle(
    //     color: ColorManager.primary, fontWeight: FontWeight.bold),
    // ),
    // ),);
  }
}
