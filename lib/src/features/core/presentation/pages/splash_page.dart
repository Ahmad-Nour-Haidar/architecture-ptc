import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/sizer_media_query.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../cubits/splash_cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  ///animation
  late AnimationController _controller;
  late Animation<double> animation;
  _initAnimation(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }
  ///end animation
  @override
  void initState() {
    super.initState();
    _initAnimation();
    context.read<SplashCubit>().initSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Hero(
            tag: 'location-image-${AssetsManager.logoIMG}',
            child: ScaleTransition(
            scale: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.logoIMG,
                  width: getWidth(context) / 1.5,
                  height: getWidth(context) / 1.5,
                ),
              ],
            ),
        ),
          ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
