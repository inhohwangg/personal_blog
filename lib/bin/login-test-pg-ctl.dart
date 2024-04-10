import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/post-list-pg.dart';
import 'package:personal_blog/global/g_dio.dart';
import 'package:personal_blog/global/g_value.dart';

class LoginTestPageController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    try {
      var res = await dio.post(
        '$baseUrl/api/collections/users/auth-with-password',
        options: Options(
          headers: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDc2NjMzMTIsImlkIjoiMjJ6bnExY3V1ZWk0c2U4IiwidHlwZSI6ImFkbWluIn0.oiJnEpQ0ZLEgUNuwkuVMN1muRQnxi7cXTsfJZ2fMnEk',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'identity': email.text,
          'password': password.text,
        },
      );
      if (res.statusCode == 200) {
        Get.snackbar('success', 'login success',
            backgroundColor: Colors.green[300]);
        Get.to(PostListPage());
      } else {
        Get.snackbar('failed', 'login failed',
            backgroundColor: Colors.red[300]);
        throw Error();
      }

      inspect(res.data);
    } catch (e) {
      print('login Error $e');
    }
  }
}
