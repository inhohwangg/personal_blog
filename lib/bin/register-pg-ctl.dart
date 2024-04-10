import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

import '../global/g_dio.dart';

class RegisterPageController extends GetxController {
  String baseUrl = 'http://127.0.0.1:8090';

  final pb = PocketBase('http://127.0.0.1:8090');
  TextEditingController userId = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController passWordConfirm = TextEditingController();
  //! 회원가입 기능
  register() async {
    try {
      var res = await dio.post(
        '$baseUrl/api/collections/users/records',
        options: Options(
          headers: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDc2NjMzMTIsImlkIjoiMjJ6bnExY3V1ZWk0c2U4IiwidHlwZSI6ImFkbWluIn0.oiJnEpQ0ZLEgUNuwkuVMN1muRQnxi7cXTsfJZ2fMnEk',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'email': userId.text,
          'password': passWord.text,
          'passwordConfirm': passWordConfirm.text,
        },
      );
      inspect(res.data);
      Get.snackbar('success', 'register success',
          backgroundColor: Colors.green, duration: Duration(seconds: 10));
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }
}
