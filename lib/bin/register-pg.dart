import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/register-pg-ctl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    RegisterPageController controller = Get.put(RegisterPageController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '아이디',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.userId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.passWord,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호 확인',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.passWordConfirm,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                controller.register();
              },
              child: Text(
                '회원가입',
              ),
            )
          ],
        ),
      ),
    );
  }
}
