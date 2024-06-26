
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/data/datasource/configuration/data_configuration.dart';
import '../core/routing/app_router.dart';
import '../core/utils/app_string.dart';
import '../core/utils/theme_manager.dart';
class PTCMyApp extends StatelessWidget {
  const PTCMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      // GetMaterialApp(
      //   locale: CoreController.instance.locale,
      //   title: AppString.appName,
      //   theme: ThemeManager.myTheme,
      //   debugShowCheckedModeBanner: false,
      //   getPages: AppPages.routes,
      //   initialRoute: AppPages.INITIAL.name,
      //
      // );
      MultiBlocProvider(
        providers: initProviders(),
        child: MaterialApp.router(
          title: AppString.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.myTheme,
          routerConfig: goRouter,
          // home: SplashPage(),
          //NavbarPage(),
        ));
  }
}

