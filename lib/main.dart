import 'dart:io';

import 'package:flutter/material.dart';

import 'core/data/datasource/configuration/locator.dart';
import 'src/app.dart';
import 'src/features/mail_box/data/datasource/remote/request_box_remote_data_source.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpoverrides();
  setupLocator();
  // final s = await RequestBoxRemoteDataSource(locator()).getRequestBoxes(page: 1, nameList: 'send');
  // print(s.runtimeType);
  // print(s.data.toString());
  runApp(const PTCMyApp());
}

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
