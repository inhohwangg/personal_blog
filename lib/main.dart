import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/pages/shop/a-home-page.dart';
import 'package:personal_blog/pages/shop/a-login-page.dart';

class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = NoCheckCertificateHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: LoginPageTestPage(),
      theme: ThemeData(fontFamily: 'Pretendard'),
      themeMode: ThemeMode.system,
      home: AloginPage(),
    );
  }
}

// 인앱결재