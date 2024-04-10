// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/login-test-pg-ctl.dart';

class LoginPageTestPage extends StatefulWidget {
  static String tag = 'login-page';

  const LoginPageTestPage({super.key});
  @override
  _LoginPageTestPageState createState() => _LoginPageTestPageState();
}

class _LoginPageTestPageState extends State<LoginPageTestPage> {
  @override
  Widget build(BuildContext context) {
    LoginTestPageController controller = Get.put(LoginTestPageController());
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: controller.email,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: controller.password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  controller.login();
                  // naverLogin();
                },
                child: Text(
                  'Login',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
