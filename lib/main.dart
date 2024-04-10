import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bin/pages/todo-bottom.dart';

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
      home: TodoBottom(),
    );
  }
}
