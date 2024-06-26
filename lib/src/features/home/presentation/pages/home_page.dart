

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/image/image_local_handler.dart';

class HomePage extends StatelessWidget {
   const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ImageLocalHandler(
        AssetsManager.logoIMG
      ),
    );

  }
}
